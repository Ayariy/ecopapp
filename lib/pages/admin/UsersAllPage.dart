import 'package:ecop_app/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecop_app/providers/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UsersAllPage extends StatefulWidget {
  const UsersAllPage({super.key});

  @override
  State<UsersAllPage> createState() => _UsersAllPageState();
}

class _UsersAllPageState extends State<UsersAllPage>
    with TickerProviderStateMixin {
  AdminProvider admin = AdminProvider();

  bool isLoading = false;
  bool isLoadingBottom = false;

  List<UserModel> listUsers = [];
  final _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  AnimationController? _animationController;

  String _fechaInit = '';
  String _fechaFin = '';
  TextEditingController _fechaInitController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _opcionSeleccionada = 'FechaCreacion';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      _agregarUsers();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_textEditingController.text == '') {
          _agregarMasUsers();
        }
      }
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    _animationController!.dispose();
  }

  TipoFechaUser _tipoFecha = TipoFechaUser.Creado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _getSearchWidget(),
          isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : listUsers.isEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      alignment: Alignment.center,
                      child: const Text('No existe usuarios por el momento'))
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: _agregarUsers,
                        child: Stack(
                          children: [
                            ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                controller: _scrollController,
                                itemCount: listUsers.length,
                                itemBuilder: (context, index) {
                                  DateTime fechaUltimavez =
                                      listUsers[index].fechaUltimavez;
                                  DateTime fechaCreacion =
                                      listUsers[index].fechaCreacion;
                                  return ListTile(
                                    leading: const Icon(Icons.date_range),
                                    title: Text(
                                        '${listUsers[index].nombre}  ${listUsers[index].apellido}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('${listUsers[index].correo}'),
                                        Text(
                                            'Ultima véz. ${getfecha(fechaUltimavez)}'),
                                        Text(
                                            'Creado. ${getfecha(fechaCreacion)}')
                                      ],
                                    ),
                                    trailing: const Icon(Icons.person),
                                  );
                                }),
                            _getLoadingMore(),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _showModalWidget();
        }),
        child: Icon(Icons.dataset_outlined),
      ),
    );
  }

  Future<void> _agregarUsers() async {
    isLoading = true;
    listUsers = await admin.getUsuarios(null);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _agregarMasUsers() async {
    setState(() {
      isLoadingBottom = true;
    });

    List<UserModel> listUsersAux =
        await admin.getUsuarios(listUsers.last.fechaCreacion);
    listUsersAux.forEach((element) {
      listUsers.add(element);
    });

    setState(() {
      isLoadingBottom = false;
    });
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 250));
  }

  Widget _getLoadingMore() {
    if (isLoadingBottom) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [CircularProgressIndicator()],
          ),
          const SizedBox(height: 15.0),
        ],
      );
    } else {
      return Container();
    }
  }

  String getfecha(DateTime fecha) {
    String fechaReturn = '';
    String dia = fecha.day < 10 ? '0${fecha.day}' : '${fecha.day}';
    String mes = fecha.month < 10 ? '0${fecha.month}' : '${fecha.month}';
    fechaReturn = '${dia}/${mes}/${fecha.year} - ${fecha.hour}:${fecha.minute}';

    return fechaReturn;
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2040),
        locale: Locale('es', 'ES'));
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && time != null) {
      setState(() {
        picked = picked!.add(Duration(hours: time.hour, minutes: time.minute));
        _fechaInit = picked.toString();

        _fechaInitController.text = DateFormat("yyyy-MM-dd HH:mm:ss", 'es')
            .format(DateTime.parse(_fechaInit));
      });
    }
  }

  void _selectDateFin(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2040),
        locale: Locale('es', 'ES'));
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && time != null) {
      setState(() {
        picked = picked!.add(Duration(hours: time.hour, minutes: time.minute));
        _fechaFin = picked.toString();

        _fechaFinController.text = DateFormat("yyyy-MM-dd HH:mm:ss", 'es')
            .format(DateTime.parse(_fechaFin));
      });
    }
  }

  void _getUsersByDate() async {
    if (_fechaFin != '' && _fechaInit != '') {
      setState(() {
        isLoading = true;
      });
      listUsers = await admin.getUserByDate(
          DateTime.parse(_fechaInit),
          DateTime.parse(_fechaFin),
          TipoFechaUser.Creado == _tipoFecha
              ? 'FechaCreacion'
              : 'FechaUltimavez');
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    } else {
      _agregarUsers();
    }
  }

  void _showModalWidget() {
    showModalBottomSheet(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setS) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filtrar por fecha',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Icon(Icons.close))
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ListTile(
                          title: const Text('Fecha de creación'),
                          leading: Radio<TipoFechaUser>(
                            value: TipoFechaUser.Creado,
                            groupValue: _tipoFecha,
                            onChanged: (TipoFechaUser? value) {
                              setS(() {
                                _tipoFecha = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Fecha última vez'),
                          leading: Radio<TipoFechaUser>(
                            value: TipoFechaUser.Ultima,
                            groupValue: _tipoFecha,
                            onChanged: (TipoFechaUser? value) {
                              setS(() {
                                _tipoFecha = value!;
                              });
                            },
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          controller: _fechaInitController,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              DateTime initDate = DateTime.parse(_fechaInit);
                              if (initDate
                                      .compareTo(DateTime.parse(_fechaFin)) <=
                                  0) {
                                return null;
                              } else {
                                return 'La fecha inicial debe ser mayor a la fecha final';
                              }
                            } else {
                              return 'Ingresa la fecha inicial del filtro';
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Agregar la fecha inicial',
                              suffixIcon:
                                  Icon(Icons.arrow_forward_ios_rounded)),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          controller: _fechaFinController,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              DateTime initDate = DateTime.parse(_fechaInit);
                              if (initDate
                                      .compareTo(DateTime.parse(_fechaFin)) <=
                                  0) {
                                return null;
                              } else {
                                return 'La fecha inicial debe ser mayor a la fecha final';
                              }
                            } else {
                              return 'Ingresa la fecha inicial del filtro';
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Agregar la fecha inicial',
                              suffixIcon:
                                  Icon(Icons.arrow_forward_ios_rounded)),
                          onTap: () {
                            _selectDateFin(context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                            minWidth: double.infinity,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: isLoading
                                  ? [const CircularProgressIndicator()]
                                  : [
                                      Icon(Icons.segment),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text('Filtrar'),
                                    ],
                            ),
                            textColor:
                                Theme.of(context).appBarTheme.foregroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      _getUsersByDate();
                                      Navigator.pop(context);
                                    }
                                  }),
                        MaterialButton(
                            minWidth: double.infinity,
                            color: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: isLoading
                                  ? [const CircularProgressIndicator()]
                                  : [
                                      Icon(Icons.close_sharp),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text('Quitar Filtro'),
                                    ],
                            ),
                            textColor:
                                Theme.of(context).appBarTheme.foregroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    _fechaInit = '';
                                    _fechaFin = '';
                                    print(_tipoFecha);
                                    _getUsersByDate();
                                    Navigator.pop(context);
                                  })
                      ],
                    )),
              );
            },
          );
        });
  }
}

enum TipoFechaUser { Creado, Ultima }

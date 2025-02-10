import 'package:flutter/material.dart';
import '/controllers/authroutes.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<dynamic> users = [];
  bool isLoading = true; // Estado de carga

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  // Función para obtener la lista de usuarios
  Future<void> _fetchUsers() async {
    try {
      final authRoutes = AuthRoutes();
      final fetchedUsers = await authRoutes.listarUsuarios();
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener usuarios: $e')),
      );
    }
  }

  // Función para borrar un usuario
  void _deleteUser(int index) async {
    final userId = users[index]['id'].toString(); // Obtener el ID del usuario
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Usuario'),
        content: Text('¿Estás seguro de que deseas eliminar este usuario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final authRoutes = AuthRoutes();
        await authRoutes.borrarUsuario(userId); // Enviar petición para borrar el usuario
        setState(() {
          users.removeAt(index); // Eliminar el usuario de la lista local
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario eliminado correctamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al borrar usuario: $e')),
        );
      }
    }
  }
  /////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ////////////////////////////////////////////////////////////
  ///
  
  //funcion para editar usuario

  void _UpdateUser(int index) async {

    TextEditingController usuarioController = TextEditingController();
    TextEditingController nombreController = TextEditingController();
    TextEditingController correoController = TextEditingController();
    TextEditingController rolController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final userId = users[index]['id'].toString(); // Obtener el ID del usuario

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Acutalizar Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("llene los campos correspondientes a Modificar"),
              TextField(
                controller: usuarioController,
                decoration: InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: rolController,
                decoration: InputDecoration(labelText: 'Rol'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed:  () async {
                Map<String, dynamic> datos = {};

                if (usuarioController.text.isNotEmpty) {
                  datos['usuario'] = usuarioController.text;
                }
                if (nombreController.text.isNotEmpty) {
                  datos['nombre'] = nombreController.text;
                }
                if (correoController.text.isNotEmpty) {
                  datos['correo'] = correoController.text;
                }
                if (rolController.text.isNotEmpty) {
                  datos['rol'] = rolController.text;
                }
                if (passwordController.text.isNotEmpty) {
                  datos['password'] = passwordController.text;
                }

                try {
                  final authRoutes = AuthRoutes();
                  await authRoutes.actualizarUsuario(userId,datos);
                  Navigator.pop(context); // Cerrar el diálogo
                  _fetchUsers(); // Recargar la lista de usuarios
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario Actualizado correctamente')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al Actualizar el usuario: $e')),
                  );
                }
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      }
    );
  }














  // Función para mostrar el diálogo de agregar usuario
  void _showAddUserDialog() {
    TextEditingController usuarioController = TextEditingController();
    TextEditingController nombreController = TextEditingController();
    TextEditingController correoController = TextEditingController();
    TextEditingController rolController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usuarioController,
                decoration: InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: rolController,
                decoration: InputDecoration(labelText: 'Rol'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Validar que todos los campos estén llenos
                if (usuarioController.text.isEmpty ||
                    nombreController.text.isEmpty ||
                    correoController.text.isEmpty ||
                    rolController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Todos los campos son obligatorios')),
                  );
                  return;
                }

                try {
                  final authRoutes = AuthRoutes();
                  await authRoutes.crearUsuario({
                    'usuario': usuarioController.text,
                    'nombre': nombreController.text,
                    'correo': correoController.text,
                    'rol': rolController.text,
                    'password': passwordController.text,
                  });
                  Navigator.pop(context); // Cerrar el diálogo
                  _fetchUsers(); // Recargar la lista de usuarios
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario agregado correctamente')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar usuario: $e')),
                  );
                }
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Usuarios'),
        backgroundColor: Color(0xFF6F61EF),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Muestra loading mientras se cargan los datos
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(users[index]['nombre'] ?? 'Sin nombre'),
                            subtitle: Text('Usuario: ${users[index]['usuario']} - Rol: ${users[index]['rol']} - Correo: ${users[index]['correo']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteUser(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
                                  onPressed: () => _UpdateUser(index),
                                ),
                              ],
                            )
                              
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showAddUserDialog,
                    child: Text('Agregar Usuario'),
                  ),
                ],
              ),
            ),
    );
  }
}
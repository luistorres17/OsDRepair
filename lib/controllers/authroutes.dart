import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRoutes {
  // URL base de la API
  //final String baseUrl = 'https://compucareitsolutions.me/api';
  final String baseUrl = 'http://localhost:3000';

  // Función para obtener el token almacenado en SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final expiration = prefs.getInt('auth_token_expiration');
    if (expiration != null && DateTime.now().millisecondsSinceEpoch < expiration) {
      return prefs.getString('auth_token');
    } else {
      // Si el token ha expirado, eliminarlo
      await prefs.remove('auth_token');
      await prefs.remove('auth_token_expiration');
      return null;
    }
  }

  // Función para listar usuarios
  Future<List<dynamic>> listarUsuarios() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No hay token de autenticación');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al listar usuarios: ${response.statusCode}');
    }
  }

  // Función para crear un nuevo usuario
  Future<dynamic> crearUsuario(Map<String, dynamic> usuario) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No hay token de autenticación');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/usuarios/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(usuario),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al crear usuario: ${response.statusCode}');
    }
  }

  // Función para borrar un usuario por ID
  Future<void> borrarUsuario(String id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No hay token de autenticación');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al borrar usuario: ${response.statusCode}');
    }
  }

  // Función para actualizar un usuario por ID
  Future<dynamic> actualizarUsuario(String id, Map<String, dynamic> usuario) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No hay token de autenticación');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(usuario),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al actualizar usuario: ${response.statusCode}');
    }
  }

  // Función para obtener un usuario por ID
  Future<dynamic> obtenerUsuario(String id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No hay token de autenticación');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener usuario: ${response.statusCode}');
    }
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  // URL de la API
  //final String apiUrl = 'https://compucareitsolutions.me/api/usuarios/login';
  final String apiUrl = 'http://localhost:3000/usuarios/login';
  // Función para realizar el login
  Future<bool> login(String usuario, String password) async {
    try {
      // Realizar la solicitud POST a la API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'usuario': usuario,
          'password': password,
        }),
      );

      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Verificar si el token está presente en la respuesta
        if (responseData.containsKey('token')) {
          final String token = responseData['token'];

          // Almacenar el token por 700 horas (700 horas * 60 minutos * 60 segundos)
          await _saveToken(token, Duration(hours: 700));

          // Retornar true para indicar que el login fue exitoso
          return true;
        }
      }

      // Si no se pudo validar el login, retornar false
      return false;
    } catch (e) {
      // Manejar cualquier error que ocurra durante la solicitud
      debugPrint('Error durante el login: $e');
      return false;
    }
  }

  // Función para almacenar el token en SharedPreferences
  Future<void> _saveToken(String token, Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('auth_token_expiration', DateTime.now().add(duration).millisecondsSinceEpoch);
  }

  // Función para obtener el token almacenado
  Future<String?> getToken() async {
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
}
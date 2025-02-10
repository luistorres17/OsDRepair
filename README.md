# OsDRepair - Sistema de Gestión de Reparaciones

[![Licencia LGPL3](https://img.shields.io/badge/Licencia-LGPL3-blue.svg)](LICENSE)

OsDRepair es un sistema de gestión de reparaciones desarrollado con Flutter para múltiples plataformas. Proporciona herramientas para administrar técnicos, clientes, usuarios y seguimiento de trabajos de reparación.

## Características Principales
- Autenticación de usuarios con JWT
- Dashboard con métricas de trabajos
- Gestión CRUD de usuarios
- Navegación por pestañas
- Integración con API REST
- Soporte multi-plataforma (Android, iOS, Web, Windows)
- Persistencia local con SharedPreferences
- Diseño responsive y moderno

## Tecnologías Utilizadas
- Flutter 3.24.0
- Dart 3.6.1
- Paquetes principales:
  - http: Para comunicación con API
  - shared_preferences: Almacenamiento local
  - percent_indicator: Indicadores de progreso
  - google_fonts: Tipografías personalizadas

## Requisitos Previos
- Flutter SDK >=3.24.0
- Dart SDK >=3.6.1
- Android Studio/Xcode (para desarrollo móvil)
- Cuenta en el servicio de API (configurar URL en el código)
- API en proceso de publicacion 

## Estructura del Proyecto
lib/
├── controllers/    # Lógica de autenticación y API
├── screens/        # Interfaces de usuario
├── main.dart       # Punto de entrada
└── dashboard.dart  # Pantalla principal



## Instalación
1. Clona el repositorio:
```bash
git clone https://github.com/luistorres17/osdrepair.git
cd osdrepair
```
2. Instala las Dependencias:
```bash
flutter pub get
```
3.Configura la API (editar en lib/controllers/authlogin.dart):
```
final String apiUrl = 'TU_ENDPOINT_API';
```

```bash
flutter run
```

## Contribución

Las contribuciones son bienvenidas. Por favor:

Haz un fork del proyecto

Crea una rama para tu feature (git checkout -b feature/nueva-feature)

Haz commit de tus cambios (git commit -m 'Añadir nueva feature')

Push a la rama (git push origin feature/nueva-feature)

Abre un Pull Request


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

## Instalación
1. Clona el repositorio:
```bash
git clone https://github.com/luistorres17/osdrepair.git
cd osdrepair
# API-BANK
API sobre datos de un banco.

# PREPARATIVOS

## SQL Server
1. Crear una base de datos utilizando el script en la carpeta "ScriptAPI" del proyecto.

## PROYECTO
1. En el archivo `appsettings.json` del proyecto, modificar la cadena de conexión a la base de datos según sea necesario. La cadena es la siguiente:
   ```json
   "ConexionSqlServer": "Server=DESKTOP-9E12MUD\\SQLEXPRESS;Database=Bank;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=true;"

## IMPORTANTE
- El puerto mostrado en las URLs puede cambiar.
- Se recomienda realizar el LOGIN en la página "Swagger" al correr el proyecto y revisar el puerto mostrado en la información para usarlo en el resto de las peticiones.

## AUTENTICACION

Para realizar cualquier petición en la API, es necesario generar un token a través del login de la siguiente manera:

1. Enviar una solicitud POST a la siguiente URL: `https://localhost:44392/Login`

2. En el cuerpo de la petición, ingresar las credenciales registradas en la base de datos en formato JSON:

{
  "email": "carlos@gmail.com",
  "pwd": "1234"
}

La respuesta de la petición será el token necesario para realizar las demás acciones de la API:

{
  "$id": "1",
  "token": "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQ2FybG9zIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiY2FybG9zQGdtYWlsLmNvbSIsImV4cCI6MTcwMTQ4NDc5Mn0.smMOE9b10HlyfXA9VbT82gHHQQ6A2aOGsB9liHirKtA"
}

Para poder realizar el resto de las peticiones es necesario que usemos el token que generamos, para ello:
1. Ir al apartado de **Authorization**
2. Seleccionar **Bearer** 
3. Ingresar el token

Para el resto de peticiones revisar la **documentación** de la API proporcionada.

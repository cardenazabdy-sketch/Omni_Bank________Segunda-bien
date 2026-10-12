1.Diseña los tipos enumerados (ENUM) del banco: 
-3 Setencias SQL

CREATE DATABASE moneda_tipo AS NUMERIC (USD, EUR, MXN)
CREATE TYPE tipo_cuenta AS ENUM (CHECKING, SAVINGS, CREDIT)
CREATE DOMAIN tipo_transaccional AS ENUM (DEPOSIT, WITHRAWAL, TRANSFER)

2.Correción de tipos nativos y especificación relacional:

     [Cuentas]                                               
Cuenta_id (PK): UUID                                  
Cliente_id (PK): UUID                                 
No.Venta: UUID                                       
Tipo_moneda (ENUM)                            
Tipo_cuenta: ENUM                
Saldo_actual: NUMERIC                               
Limite_credito


     [Clientes]  
Cliente_id (PK): UUID 
Nombre: VARCHAR 
Correo: VARCHAR
No.Telefono: Único
Fecha_nacimiento: DATE 
No.Identificación: UUID


    [Transacciones]
Tipo_transaccion: UUID
Fecha_exacta: Automático
Cuenta_destino (FK): Único
Monto (FK): VARCHAR
Estado: VARCHAR

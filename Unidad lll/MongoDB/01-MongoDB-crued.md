# MongoDB Crued 

## Crear una bose de datos

**solo se crea si tiene una coleccion** 


```json
use 'nombre de la base de datos'

use db1

```
![alt text](IMG/1.png)

`use db1
db.createCollection('empleado')`

![alt text](IMG/2.png)
## Mostrar la collection 
`show collections`

![alt text](IMG/4.png)

## Insercion de un Documento

```json
db.Empleado.insertOne(
    {
    nombre:'Andrea',
    apellido: 'cruz',
    edad: 23 ,
    ciudad: 'San migen de la priedas'
    }
)
```
![alt text](IMG/3.png)

# Minecraft Crafting Recipes API utal
## Estructura del proyecto
Se realizó la estructura del proyecto Flutter, donde tenemos las entidades, las pantallas y los servicios que conectan la API con el proyecto. Tenemos profile.dart sin funcionalidad pero implementada en la carpeta lib, además se añadió también una carpeta "core" para tener funciones dinámicas como un estilo de texto editable en una pura clase (text_style.dart).
![image](https://github.com/user-attachments/assets/c412e631-291f-4c24-8897-fe827b9a92ce)

En este caso, la entidad CraftingRecipe representa una "receta de crafteo", donde se requieren los items, la cantidad que saldrá de ese crafteo, "shapeless" que significa que no tiene forma a seguir para craftear (con solo estar en una de las rejillas 9x9 de la mesa de crafteo, funciona), y un recipe que es la receta como tal a seguir.
> Evidencia de uno de los \entity
![image](https://github.com/user-attachments/assets/5842efc0-94da-4526-95c2-9a0fba58ade2)

Por su parte, y siguiendo el mismo caso, en servicios se conecta al endpoint de la API que estamos utilizando, y por medio de un GET, se interpreta la información de JSON y se obtienen los datos de las recetas para utilizarlos en la lógica de nuestra aplicacion.
> Ejemplo de uno de los \services
![image](https://github.com/user-attachments/assets/0fbeedd8-51fc-4187-a9b1-6650bee82449)

### Link API
https://anish-shanbhag.stoplight.io/docs/minecraft-api/3c83c30abf558-get-crafting-recipes

[README dm3_v2.pdf](https://github.com/user-attachments/files/21059355/README.dm3_v2.pdf)

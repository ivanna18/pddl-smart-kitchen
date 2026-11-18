# Smart Kitchen: planificación automatizada con PDDL

Proyecto final (PIA) de [nombre del curso]. Modelo una cocina de restaurante
que debe preparar y entregar tres pedidos (hamburguesa, pasta y ensalada)
con recursos limitados: una estación de preparación, una estufa, un área de
ensamblaje y un área de entrega.

## Archivos
- `domain.pddl`: tipos, predicados y 8 esquemas de acción.
- `problem.pddl`: 3 pedidos, 8 ingredientes y 4 estaciones.
- `DISEÑO.md`: proceso de diseño y diferencias con dominios de inspiración.
- Video demo: 

El dominio usa `:negative-preconditions` y `:existential-preconditions`,
así que se necesita un planificador que los soporte.

## Plan obtenido (21 pasos)
```
 1. (preparar-ensalada en1 lechuga1 tomate1 aderezo1 prep1)
 2. (liberar-estacion en1 prep1)
 3. (ensamblar-frio en1 ensam1)
 4. (preparar-pasta pa1 pasta1 salsa1 prep1)
 5. (liberar-estacion pa1 prep1)
 6. (cocinar-pedido pa1 estufa1)
 7. (preparar-hamburguesa h1 pan1 carne1 queso1 prep1)
 8. (liberar-estacion en1 ensam1)
 9. (entregar-pedido en1 entrega1)
10. (liberar-estacion pa1 estufa1)
11. (ensamblar-cocinado pa1 ensam1)
12. (liberar-estacion h1 prep1)
13. (cocinar-pedido h1 estufa1)
14. (liberar-estacion en1 entrega1)
15. (liberar-estacion pa1 ensam1)
16. (entregar-pedido pa1 entrega1)
17. (liberar-estacion h1 estufa1)
18. (ensamblar-cocinado h1 ensam1)
19. (liberar-estacion pa1 entrega1)
20. (liberar-estacion h1 ensam1)
21. (entregar-pedido h1 entrega1)
```
# Proceso de diseño

## 1. Escenario
Una cocina recibe tres pedidos con ingredientes y rutas distintas y debe
entregarlos todos usando estaciones compartidas, sin usar una estación
ocupada y sin entregar un pedido incompleto.


## 2. Predicados (10) y por qué
| Predicado | Para qué |
|---|---|
| `ingrediente-disponible ?i` | Inventario: qué ingredientes quedan |
| `requiere ?p ?i` | Qué ingredientes lleva cada pedido |
| `preparado`, `cocinado`, `ensamblado`, `entregado` `?p` | Etapa en la que va cada pedido |
| `necesita-coccion ?p`, `sin-coccion ?p` | Ruta del pedido (con o sin cocción) |
| `estacion-libre ?e` | Si una estación está disponible |
| `asignado ?p ?e` | Qué pedido ocupa qué estación |

Nota: `sin-coccion` equivale a `(not (necesita-coccion ?p))`; lo conservé
por legibilidad. 

## 3. Tipos
`pedido` (hamburguesa, pasta-pedido, ensalada), `estacion` (estacion-prep,
estufa, area-ensamblaje, area-entrega) e `ingrediente` con un subtipo por
ingrediente. Los subtipos de ingrediente evitan que un mismo objeto ocupe
dos parámetros de una acción y deje un pedido incompleto.

## 4. Acciones
| Acción | Precondiciones | Agrega | Elimina |
|---|---|---|---|
| `preparar-hamburguesa` / `-pasta` / `-ensalada` | Estación de preparación libre, pedido no preparado, requiere sus ingredientes y están disponibles | `preparado`, `asignado` | `estacion-libre`, `ingrediente-disponible` de cada ingrediente |
| `cocinar-pedido` | Preparado, necesita cocción, no cocinado ni ensamblado, estufa libre, sin estación asignada | `cocinado`, `asignado` | `estacion-libre` |
| `ensamblar-cocinado` | Cocinado, no ensamblado, área libre, sin estación asignada | `ensamblado`, `asignado` | `estacion-libre` |
| `ensamblar-frio` | Preparado, `sin-coccion`, no ensamblado, área libre, sin estación asignada | `ensamblado`, `asignado` | `estacion-libre` |
| `entregar-pedido` | Ensamblado, no entregado, área de entrega libre, sin estación asignada | `entregado`, `asignado` | `estacion-libre` |
| `liberar-estacion` | `asignado ?p ?e` | `estacion-libre` | `asignado` |

## 5. Cómo llegué al esquema final
- **Versión 1:** [TU VOZ: describe tu primera versión.] Tenía una acción de
  preparar por platillo y las etapas cocinar, ensamblar y entregar, pero
  ninguna acción usaba estaciones, así que el problema de recursos
  compartidos no estaba modelado.
- **Problema detectado:** los parámetros de ingredientes eran todos de tipo
  `ingrediente`, de modo que el planificador podía asignar el mismo objeto a
  varios parámetros y dejar un pedido "preparado" sin consumir todos sus
  ingredientes. Lo resolví con un tipo por ingrediente.
- **Versión 2:** agregué tipos de estación, `estacion-libre`, `asignado` y
  `liberar-estacion`.
- **Versión final:** agregué la condición
  `(not (exists (?x - estacion) (asignado ?p ?x)))` en cocinar, ensamblar y
  entregar: un pedido debe soltar su estación antes de avanzar. Así no
  acapara dos estaciones a la vez y el planificador debe turnar los pedidos.
  [TU VOZ: por qué decidiste esto.]
- **Dos caminos de ensamblaje:** `ensamblar-cocinado` y `ensamblar-frio`
  logran el mismo efecto para pedidos con y sin cocción.

## 6. Decisiones y limitaciones
- La pasta pasa por el área de ensamblaje (que también empaca).
- Hay una unidad de cada ingrediente y una estación de cada tipo.
- No se modelan tiempos, costos ni cantidades.
- Requiere un planificador con precondiciones negativas y existenciales.

## 7. Resultado
El planificador encontró un plan válido de 21 pasos (11 acciones de etapa y
10 liberaciones). Ver `README.md`.
(define (problem cocina-tres-pedidos)

  (:domain smart-kitchen)

  (:objects

    ;; Pedidos
    h1 - hamburguesa
    pa1 - pasta-pedido
    en1 - ensalada

    ;; Ingredientes
    pan1 - pan
    carne1 - carne
    queso1 - queso

    pasta1 - pasta
    salsa1 - salsa

    lechuga1 - lechuga
    tomate1 - tomate
    aderezo1 - aderezo

    ;; Estaciones
    prep1 - estacion-prep
    estufa1 - estufa
    ensam1 - area-ensamblaje
    entrega1 - area-entrega
  )

  (:init

    ;; INVENTARIO INICIAL

    (ingrediente-disponible pan1)
    (ingrediente-disponible carne1)
    (ingrediente-disponible queso1)

    (ingrediente-disponible pasta1)
    (ingrediente-disponible salsa1)

    (ingrediente-disponible lechuga1)
    (ingrediente-disponible tomate1)
    (ingrediente-disponible aderezo1)

    ;; INGREDIENTES DE CADA PEDIDO

    (requiere h1 pan1)
    (requiere h1 carne1)
    (requiere h1 queso1)

    (requiere pa1 pasta1)
    (requiere pa1 salsa1)

    (requiere en1 lechuga1)
    (requiere en1 tomate1)
    (requiere en1 aderezo1)

    ;; REQUISITOS DE COCCION

    (necesita-coccion h1)
    (necesita-coccion pa1)

    (sin-coccion en1)

    ;; TODAS LAS ESTACIONES COMIENZAN LIBRES

    (estacion-libre prep1)
    (estacion-libre estufa1)
    (estacion-libre ensam1)
    (estacion-libre entrega1)
  )

  ;; META: ENTREGAR LOS TRES PEDIDOS

  (:goal
    (and
      (entregado h1)
      (entregado pa1)
      (entregado en1)
    )
  )
)
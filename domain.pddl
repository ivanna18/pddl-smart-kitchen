
(define (domain smart-kitchen)

  (:requirements
    :strips
    :typing
    :negative-preconditions
    :existential-preconditions

  )

  (:types
    pedido estacion ingrediente - object

    hamburguesa pasta-pedido ensalada - pedido

    estacion-prep estufa area-ensamblaje area-entrega - estacion

    pan carne queso pasta salsa lechuga tomate aderezo - ingrediente
  )

  (:predicates

    ;; Inventario
    (ingrediente-disponible ?i - ingrediente)
    (requiere ?p - pedido ?i - ingrediente)

    ;; Estado de los pedidos
    (preparado ?p - pedido)
    (cocinado ?p - pedido)
    (ensamblado ?p - pedido)
    (entregado ?p - pedido)

    ;; Requisitos de preparacion
    (necesita-coccion ?p - pedido)
    (sin-coccion ?p - pedido)

    ;; Control de estaciones
    (estacion-libre ?e - estacion)
    (asignado ?p - pedido ?e - estacion)
  )

  ;; PREPARAR HAMBURGUESA

  (:action preparar-hamburguesa
    :parameters (
      ?p - hamburguesa
      ?pan - pan
      ?carne - carne
      ?queso - queso
      ?e - estacion-prep
    )

    :precondition (and
      (estacion-libre ?e)
      (not (preparado ?p))
      (requiere ?p ?pan)
      (requiere ?p ?carne)
      (requiere ?p ?queso)
      (ingrediente-disponible ?pan)
      (ingrediente-disponible ?carne)
      (ingrediente-disponible ?queso)
    )

    :effect (and
      (preparado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
      (not (ingrediente-disponible ?pan))
      (not (ingrediente-disponible ?carne))
      (not (ingrediente-disponible ?queso))
    )
  )

  ;; PREPARAR PASTA

  (:action preparar-pasta
    :parameters (
      ?p - pasta-pedido
      ?pasta - pasta
      ?salsa - salsa
      ?e - estacion-prep
    )

    :precondition (and
      (estacion-libre ?e)
      (not (preparado ?p))
      (requiere ?p ?pasta)
      (requiere ?p ?salsa)
      (ingrediente-disponible ?pasta)
      (ingrediente-disponible ?salsa)
    )

    :effect (and
      (preparado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
      (not (ingrediente-disponible ?pasta))
      (not (ingrediente-disponible ?salsa))
    )
  )

  ;; PREPARAR ENSALADA

  (:action preparar-ensalada
    :parameters (
      ?p - ensalada
      ?lechuga - lechuga
      ?tomate - tomate
      ?aderezo - aderezo
      ?e - estacion-prep
    )

    :precondition (and
      (estacion-libre ?e)
      (not (preparado ?p))
      (requiere ?p ?lechuga)
      (requiere ?p ?tomate)
      (requiere ?p ?aderezo)
      (ingrediente-disponible ?lechuga)
      (ingrediente-disponible ?tomate)
      (ingrediente-disponible ?aderezo)
    )

    :effect (and
      (preparado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
      (not (ingrediente-disponible ?lechuga))
      (not (ingrediente-disponible ?tomate))
      (not (ingrediente-disponible ?aderezo))
    )
  )

  ;; COCINAR PEDIDO

  (:action cocinar-pedido
    :parameters (
      ?p - pedido
      ?e - estufa
    )

    :precondition (and
      (preparado ?p)
      (necesita-coccion ?p)
      (not (cocinado ?p))
      (not (ensamblado ?p))
      (estacion-libre ?e)
      (not (exists (?x - estacion) (asignado ?p ?x)))
    )

    :effect (and
      (cocinado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
    )
  )

  ;; ENSAMBLAR PEDIDO COCINADO

  (:action ensamblar-cocinado
    :parameters (
      ?p - pedido
      ?e - area-ensamblaje
    )

    :precondition (and
      (cocinado ?p)
      (not (ensamblado ?p))
      (estacion-libre ?e)
      (not (exists (?x - estacion) (asignado ?p ?x)))
    )

    :effect (and
      (ensamblado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
    )
  )

  ;; ENSAMBLAR PEDIDO SIN COCCION

  (:action ensamblar-frio
    :parameters (
      ?p - pedido
      ?e - area-ensamblaje
    )

    :precondition (and
      (preparado ?p)
      (sin-coccion ?p)
      (not (ensamblado ?p))
      (estacion-libre ?e)
      (not (exists (?x - estacion) (asignado ?p ?x)))
    )

    :effect (and
      (ensamblado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
    )
  )

  ;; ENTREGAR PEDIDO

  (:action entregar-pedido
    :parameters (
      ?p - pedido
      ?e - area-entrega
    )

    :precondition (and
      (ensamblado ?p)
      (not (entregado ?p))
      (estacion-libre ?e)
      (not (exists (?x - estacion) (asignado ?p ?x)))
    )

    :effect (and
      (entregado ?p)
      (asignado ?p ?e)
      (not (estacion-libre ?e))
    )
  )

  ;; LIBERAR ESTACION

  (:action liberar-estacion
    :parameters (
      ?p - pedido
      ?e - estacion
    )

    :precondition (asignado ?p ?e)

    :effect (and
      (estacion-libre ?e)
      (not (asignado ?p ?e))
    )
  )
)
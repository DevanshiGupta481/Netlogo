breed [ nutrients nutrient ]
patches-own [ liviness ]

to setup
  ca
  create-turtles num-hyphae [
    setxy random-xcor min-pycor set heading 0 live
    set color white set size 2
  ]
  reset-ticks
end

to setup-nutrients
  create-turtles 1000 [
    set breed nutrients
    set color blue set shape "circle"
    setxy random-xcor min-pycor set heading 0
  ]
end

to grow
  ask turtles [ wiggle fd 1 live ]
  if remainder ticks branch-time = 0 [ branch ]
  tick
end

to live
  set liviness liviness + 1
  set pcolor white
end

to wiggle
  right random wiggle-angle
  left random wiggle-angle
end

to branch
  ask n-of random num-hyphae turtles [
    hatch 1 [
      ifelse random-float 1.0 < 0.5 [left 45][right 45]
    ]
  ]
end

to flow
  ask nutrients [
    cross-check
    if patch-ahead 1 != NOBODY [
    ifelse [ liviness ] of patch-ahead 1 > 0 [
      fd 1 pd][
        right random 45
        left random 45
        fd 0.1
    ]
    ]
  ]
end

to cross-check
  move-to patch-here
  let forward-neighbors patches in-cone 10 60
  face max-one-of forward-neighbors [ liviness ]
end

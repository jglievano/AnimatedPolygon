# AnimatedPolygon

Draws an animated triangle that decreased in size with its focal point at the
center of the screen.

Once the center is reached, it starts growing downwards.

## Trigonometry

The angle of the "focal point" at the center of the screen is calculated using
`tan`. This allows to calculate `x` and `y` coordinates that vary as a
percentage of the triangle is being drawn.

If wanted to create a sand clock effect you'd need to stop the animation once
`fillPct` in `PolygonView` reaches `0`. At the same time, you would want to
draw another shape, using the same `Shape` and `UIBezierPath` technique shown
in `PolygonView`, drawing a _4 sided polygon_ starting at the bottom of the
screen. Biggest challenge is the math, since you'd need to calculate the angle
of polygon bottom left part (is the same as the bottom right one).
Fortunately, we can easily calculate that given we already did for the top
triangle, and the formula would be `90 - angle`.

## UI

- UIViewController (Main View Controller)
    - Timer: to handle the animation
    - PolygonView: to handle the drawing
        - Shape: contains the shape being drawn

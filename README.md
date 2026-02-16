# Pixel Art Game Template
Pixel art game template for godot, mainly for game jam usage.
Merge the desired template into main and optionally remove the other.

## Both Tempalates
 - Rudimentary game menu, level, and end screen
 - PhantomCamera for smooth camera movement
 - Scene transition system along with a simple wipe animation
 - Separate world and GUI scenes
 - Scene debug tools (previous, restart, next)
 - Maintains a 16:9 ratio

## Pixel Perfect Template
 - Worlds are rendered at strictly 320x180
 - Objects snapped to the pixel grid except for the camera
 - GUI is high res at 1920x1080
 - Game only scales by integer sizes of 1920x1080

## Pixel Imperfect Template
 - World rendered with a [manual pixel filtering shader](https://colececil.dev/blog/2017/scaling-pixel-art-without-destroying-it/) to reduce distortion without blurring
 - Game scales to any resolution
# StrangePlaces

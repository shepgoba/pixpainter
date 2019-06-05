module editor.color;

import std.stdio;
import derelict.sdl2.sdl;

struct Color
{
    /// RGBA channels
    ubyte r,g,b,a;
}

enum ColorMode
{
    // TODO: Possibly add more color modes?

    fullColor,      /// The document uses full 24 bit color
    grayscale,      /// The document uses grayscale
    indexedColor,   /// The document uses indexed-mode color
}

/// Convert from an SDL_Color to a Color
Color fromSDL(SDL_Color color)
{
    Color newColor = {r: color.r, g: color.g, b: color.b, a: color.a};
    return newColor;
}

/// Convert from a Color to an SDL_Color
SDL_Color toSDL(Color color)
{
    SDL_Color newColor = {r: color.r, g: color.g, b: color.b, a: color.a};
    return newColor;
}
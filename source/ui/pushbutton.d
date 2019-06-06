module ui.pushbutton;

import std.stdio;
import std.path : buildPath;
import std.file : getcwd;
import std.string : toStringz;
import derelict.sdl2.sdl;
import derelict.sdl2.ttf;
import ui.units : Point, Size;
import ui.button;
import editor.color;

class PushButton : Button
{
    private string _text;
    private Point _position;
    private Size _size;
    private ButtonState _buttonState;

    private TTF_Font* titleFont;

    /// Getter and setter for text
    @property string text() { return _text; }
    @property void text(string s) { _text = s; }

    /// Getter and setter for position
    @property Point position() { return _position; }
    @property void position(Point p) { _position = p; }

    /// Getter and setter for size
    @property Size size() { return _size; }
    @property void size(Size sz) { _size = sz; }

    /// Getter for button state
    @property ButtonState buttonState() { return _buttonState; }

    this()
    {
      // TODO: Notify when loop has ended to destroy font
      titleFont = TTF_OpenFont(toStringz(buildPath(getcwd(), "resources/fonts/Fipps-Regular.ttf")), 16);
  }

  override void render(SDL_Renderer* context)
  {
        // TODO: Implement rendering code
        SDL_SetRenderDrawColor(context, 196, 196, 196, 255);

        // Drawing the background rectangle
        SDL_Rect rect = {x: position.x, y: position.y, w: size.w, h: size.h};
        SDL_RenderFillRect(context, &rect);

        // Drawing the title
        SDL_Color titleColor = Color(0, 0, 0, 255).toSDL;
        
        if (titleFont == null) {
            // TODO: Add error handling
            writefln("Font file not found");
            return;
        }

        SDL_Surface* titleSurface = TTF_RenderText_Solid(titleFont, toStringz(text), titleColor);

        SDL_Rect titlePosition = {x: ((rect.w - titleSurface.w) / 2) + rect.x, y: ((rect.h - titleSurface.h) / 2) + rect.y, w: titleSurface.w, h: titleSurface.h};
        SDL_Texture* titleLabelTexture = SDL_CreateTextureFromSurface(context, titleSurface);
        SDL_RenderCopy(context, titleLabelTexture, null, &titlePosition);
        SDL_FreeSurface(titleSurface);
        SDL_DestroyTexture(titleLabelTexture);

    }

    override void processEvents(SDL_Event* event) 
    {
        // TODO: Process events
    }
}

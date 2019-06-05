module ui.pushbutton;

import derelict.sdl2.sdl;
import ui.units : Point, Size;
import ui.button;

class PushButton : Button
{
    private string _text;
    private Point _position;
    private Size _size;
    private ButtonState _buttonState;

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

    override void render(SDL_Renderer* context)
    {
        // TODO: Implement rendering code
        SDL_SetRenderDrawColor(context, 196, 196, 196, 255);

        SDL_Rect rect = {x: position.x, y: position.y, w: size.w, h: size.h};
        SDL_RenderFillRect(context, &rect);
    }

    override void processEvents(SDL_Event* event) 
    {
        // TODO: Process events
    }
}

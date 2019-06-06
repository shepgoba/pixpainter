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

/**
 * A push button control that has a title, position, size, text and text size. 
 * 
 * It can be given a custom action to execute when pressed, and handles state updates
 * with the main event loop.
**/
class PushButton : Button
{
    private string _text = "Button";
    private int _textSize = 16;
    private int _lastKnownTextSize;
    private Point _position = Point(0, 0);
    private Size _size = Size(200, 50);
    private ButtonState _buttonState = ButtonState.normal;

    /// Font used for the button title
    private TTF_Font* _titleFont;

    /// Getter and setter for text
    @property string text() { return _text; }
    @property void text(string s) { _text = s; }

    /// Getter and setter for text size (in pt)
    @property int textSize() { return _textSize; }
    @property void textSize(int i) { _textSize = i; }

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
        if (_lastKnownTextSize != _textSize) {
            _titleFont = TTF_OpenFont(toStringz(buildPath(getcwd(), "resources/fonts/nokiafc22.ttf")), _textSize);
            _lastKnownTextSize = _textSize;
        }

        if (buttonState == ButtonState.normal) {
            // Normal state
            SDL_SetRenderDrawColor(context, 196, 196, 196, 255);
        }
        else if (buttonState == ButtonState.pressed) {
            // Pressed state
            SDL_SetRenderDrawColor(context, 249, 192, 0, 255);
        }

        // Drawing the background rectangle
        SDL_Rect rect = {x: position.x, y: position.y, w: size.w, h: size.h};
        SDL_RenderFillRect(context, &rect);

        // Drawing the title
        SDL_Color titleColor = Color(0, 0, 0, 255).toSDL;

        if (_titleFont == null) {
            // TODO: Add error handling
            writefln("Font file not found");
            return;
        }

        SDL_Surface* titleSurface = TTF_RenderText_Solid(_titleFont, toStringz(text), titleColor);

        // Calculate the position of the text to center it, kudos to harrie
        immutable int offsetX = ((rect.w - titleSurface.w) / 2) + rect.x;
        immutable int offsetY = ((rect.h - titleSurface.h) / 2) + rect.y;

        SDL_Rect titlePosition = {x: offsetX, y: offsetY, w: titleSurface.w, h: titleSurface.h};
        SDL_Texture* titleLabelTexture = SDL_CreateTextureFromSurface(context, titleSurface);
        SDL_RenderCopy(context, titleLabelTexture, null, &titlePosition);
        SDL_FreeSurface(titleSurface);
        SDL_DestroyTexture(titleLabelTexture);

    }

    override void processEvents(SDL_Event* event) 
    {
        // TODO: Process events
        if (event.type == SDL_MOUSEBUTTONDOWN)
        {
            // Check for left mouse button
            if (event.button.button == SDL_BUTTON_LEFT)
            {
                int mouseX, mouseY;
                SDL_GetMouseState(&mouseX, &mouseY);

                // Check whether the mouse position is inside the button
                immutable bool isInsideBox = (mouseX > position.x && mouseX < position.x + size.w &&
                                              mouseY > position.y && mouseY < position.y + size.h);
                if (isInsideBox)
                {
                    _buttonState = ButtonState.pressed;
                }
            }
        }
        else if (event.type == SDL_MOUSEBUTTONUP)
        {
            // Reset the button state on mouse up
            _buttonState = ButtonState.normal;
        }
    }
}

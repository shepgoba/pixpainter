module ui.label;

import std.stdio;
import std.path : buildPath;
import std.file : getcwd;
import std.string : toStringz;
import derelict.sdl2.sdl;
import derelict.sdl2.ttf;

import ui.units : Point;
import editor.color;

/**
 * A simple label class that has customizable text, position, text size, text color and background color
 * 
**/

class Label
{
    private string _text;
    private Point _position;
    private Color _textColor;
    private int _textSize;
    private Color _backgroundColor;

    private SDL_Texture* textTexture;

    /// Getter and setter for text
    @property string text() { return _text; }
    @property void text(string s) { _text = s; }

    /// Getter and setter for position
    @property Point position() { return _position; }
    @property void position(Point p) { _position = p; }

    /// Getter and setter for text color
    @property Color textColor() { return _textColor; }
    @property void textColor(Color c) { _textColor = c; }

    /// Getter and setter for text size
    @property int textSize() { return _textSize; }
    @property void textSize(int s) { _textSize = s; }

    /// Getter and setter for background color
    @property Color backgroundColor() { return _backgroundColor; }
    @property void backgroundColor(Color bg) { _backgroundColor = bg; }

    // Add an option to not initialize at instantiation
    this()
    {

    }

    // Add an option to initialize at instantiation without a background color
    this(string text, Point position, int textSize, Color textColor)
    {
        this.text = text;
        this.position = position;
        this.textSize = textSize;
        this.textColor = textColor;
    }

    // Add an option to initialize at instantiation with a background color
    this(string text, Point position, int textSize, Color textColor, Color backgroundColor)
    {
        this.text = text;
        this.position = position;
        this.textSize = textSize;
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
    }

    void initialize(SDL_Renderer* context)
    {
        //Font to use for text
        TTF_Font* textFont = TTF_OpenFont(toStringz(buildPath(getcwd(), "resources/fonts/nokiafc22.ttf")), _textSize);
        if (textFont == null) {
            // TODO: Add error handling
            writeln("Font file not found");
            return;
        } 

        SDL_Surface* textSurface;

        //check if a background color has been defined. If so, we render it with a background; otherwise, just render the text
        if (backgroundColor == Color()) {
            textSurface = TTF_RenderText_Blended(textFont, toStringz(text), textColor.toSDL);
        }
        else {
            textSurface = TTF_RenderText_Shaded(textFont, toStringz(text), textColor.toSDL, backgroundColor.toSDL);
        }
        
        if (textSurface == null) {
            // TODO: Add error handling
            writeln("Error loading label text surface");
            return;
        } 

        textTexture = SDL_CreateTextureFromSurface(context, textSurface);
        if (textTexture == null) {
            // TODO: Add error handling
            writeln("Error loading label text texture");
            return;
        } 

        SDL_FreeSurface(textSurface);
        TTF_CloseFont(textFont);
    }

    void render(SDL_Renderer* context)
    {
        //Get text width and height automatically (no need for a Size variable)
        int textTextureWidth, textTextureHeight;
        SDL_QueryTexture(textTexture, null, null, &textTextureWidth, &textTextureHeight);

        SDL_Rect textRect = {x: position.x, y: position.y, w: textTextureWidth, h: textTextureHeight};

        SDL_RenderCopy(context, textTexture, null, &textRect);

    }

    void cleanup()
    {
        SDL_DestroyTexture(textTexture);
    }
}
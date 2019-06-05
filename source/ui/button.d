module ui.button;
import derelict.sdl2.sdl;

enum ButtonState
{
    normal,
    pressed,
    disabled
}

class Button
{
    abstract void render(SDL_Renderer* context);
    abstract void processEvents(SDL_Event* event);
}
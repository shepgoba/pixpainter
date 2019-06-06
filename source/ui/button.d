module ui.button;
import derelict.sdl2.sdl;

enum ButtonState
{
    normal,
    pressed,
}

class Button
{
    /// Create all elements for render loop
    abstract void initialize(SDL_Renderer* context);
    /// Called within the render loop
    abstract void render(SDL_Renderer* context);
    /// Process events called from the main loop, e.g. clicks
    abstract void processEvents(SDL_Event* event);
    
    /// Called when needs to clean up all elements in memory
    abstract void cleanup();
}
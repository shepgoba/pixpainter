import std.stdio;
import derelict.sdl2.sdl;
import derelict.sdl2.ttf;

import editor.editor : Editor;
import editor.color;

import ui.units;
import ui.pushbutton;
import ui.label;

private __gshared SDL_Window* window;
private __gshared SDL_Renderer* renderer;
private __gshared bool hasQuit;

private __gshared Editor editorInstance;

void main()
{
    // Load SDL2
    DerelictSDL2.load();
    DerelictSDL2ttf.load();

    sdlMain();
}

void sdlMain()
{
    SDL_Init(SDL_INIT_VIDEO);
    TTF_Init();

    window = SDL_CreateWindow("pixpainter", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_OPENGL);

    if (window == null) 
    {
        writefln("Could not create window: %s", SDL_GetError());
        return;
    }

    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    // TODO: Remove later
    PushButton button = new PushButton("Hello World", Point(64, 64), Size(100, 24), 11);
    Label aLabel = new Label("I am a label", Point(300, 50), 24, Color(0, 255, 0, 255), Color(100, 100, 100));
    Label anotherLabel = new Label("I am also a label", Point(50, 300), 16, Color(255, 0, 0, 255));

    button.initialize(renderer);
    aLabel.initialize(renderer);
    anotherLabel.initialize(renderer);

    while (!hasQuit)
    {
        SDL_Event event;
        while(SDL_PollEvent(&event))
        {

            button.processEvents(&event);

            // Pump events from the event queue
            if (event.type == SDL_QUIT) {
                hasQuit = true;
            }
        }

        // Render other stuff here
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        SDL_RenderClear(renderer);

        button.render(renderer);
        aLabel.render(renderer);
        anotherLabel.render(renderer);
        SDL_RenderPresent(renderer);
    }

    button.cleanup();
    aLabel.cleanup();
    anotherLabel.cleanup();
    
    // Clean up
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    TTF_Quit();
    SDL_Quit();
}
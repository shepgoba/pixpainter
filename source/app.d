import std.stdio;
import derelict.sdl2.sdl;
import derelict.sdl2.ttf;

import editor.editor : Editor;
import editor.color;

import ui.units;
import ui.pushbutton;

private __gshared SDL_Window* window;
private __gshared SDL_Renderer* renderer;
private __gshared bool hasQuit;

private __gshared Editor editorInstance;

void main()
{
	// Load SDL2
	DerelictSDL2.load();
  DerelictSDL2ttf.load();
  TTF_Init();

	sdlMain();
}

void sdlMain()
{
	SDL_Init(SDL_INIT_VIDEO);
	window = SDL_CreateWindow("pixpainter", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_OPENGL);

	if (window == null) 
	{
		writefln("Could not create window: %s", SDL_GetError());
		return;
	}

	renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    PushButton button = new PushButton();
    button.position = Point(64, 64);
    button.size = Size(200, 40);
    button.text = "Hello World";

	while (!hasQuit)
	{
		SDL_Event event;
		while(SDL_PollEvent(&event))
		{
			// Pump events from the event queue
			if (event.type == SDL_QUIT) {
				hasQuit = true;
			}
		}

		// Render other stuff here
		SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
		SDL_RenderClear(renderer);

		button.render(renderer);

		SDL_RenderPresent(renderer);
	}

	// Clean up
	SDL_DestroyWindow(window);
	SDL_Quit();
}

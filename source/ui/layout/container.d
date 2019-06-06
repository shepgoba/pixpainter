module ui.layout.container;

import std.stdio;
import derelict.sdl2.sdl;
import derelict.sdl2.ttf;

/**
 * A container that stores a collection of UI controls and specifies the order to render child controls.
 *
 * This is the base Container type, and is not expected to be used by itself.
 *
 * Instead, use a `ui.layout.vbox` if you want vertical layout controls, and a `ui.layout.hbox` if
 * you wish for the controls to be lay out horizontally. There are also special classes like `ui.layout.list`.
 */
class Container
{

}
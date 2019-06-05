module editor.editor;

import std.stdio;
import derelict.sdl2.sdl;
import editor.color;

enum Tool
{
    arrow,      // Arrow tool, no action
    pencil,     // Pencil tool
    floodFill,  // Flood fill tool
    eraser,     // Eraser tool
    eyeDropper, // Eye-dropper/color picker tool
    selection,  // Rectangular selection tool
}

class Editor
{
    /// Whether there is a current document open or not
    bool hasDocumentOpen;

    /// Whether there is a current palette loaded or not
    bool hasPalette;

    /// Current color mode for the open document
    ColorMode colorMode;

    /// The currently selected tool
    Tool selectedTool;

    /// Colors that are in the current palette, if any
    Color[] currentPalette;
}
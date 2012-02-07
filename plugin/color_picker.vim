"Script: VIM Color Picker
"Version: 0.1
"Copyright: Copyright (C) 2010  Fabien Loison
"Licence: GPLv3+ (see the "COPYING" file for more information)
"Website: http://www.flogisoft.com/
"
"DEPENDENCIES:
"  For working, this script need:
"    * VIM 7.x with Python support
"    * PyGTK 2.x
"
"INSTALL:
"  Just copy "color_picker.vim" in your pluggin directory.
"
"USE:
"  When your are in insert mode or visual mode, press the <F5> button.
"  The color picker dialog appear, select a color and validate.
"


imap <F5> <Esc>:ColorPicker<Cr>a
vmap <F5> <Del><Esc>h:ColorPicker<Cr>a

command ColorPicker call ColorPicker()

function! ColorPicker()
python << EOF
import pygtk
pygtk.require('2.0')
import gtk
import vim

color_sel = gtk.ColorSelectionDialog("VIM Color Picker")

if color_sel.run() == gtk.RESPONSE_OK:
    color = color_sel.colorsel.get_current_color()
    #Convert to 8bit channels
    red = color.red * 255 / 65535
    green = color.green * 255 / 65535
    blue = color.blue * 255 / 65535
    #Convert to hexa strings
    red = str(hex(red))[2:]
    green = str(hex(green))[2:]
    blue = str(hex(blue))[2:]
    #Format
    if len(red) == 1:
        red = "0%s" % red
    if len(green) == 1:
        green = "0%s" % green
    if len(blue) == 1:
        blue = "0%s" % blue
    print red, green, blue
    #Merge
    color = "#%s%s%s" % (red, green, blue)
    #Get cursor position
    pos_y, pos_x = vim.current.window.cursor
    #Insert
    vim.current.line = vim.current.line[:pos_x+1] + color + vim.current.line[pos_x+1:]
    #Move cursor
    vim.current.window.cursor = (pos_y, pos_x+7)

#Close dialog
color_sel.destroy()

EOF
endfunction



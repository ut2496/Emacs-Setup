# My Emacs Setup

My Personal Emacs setup. Includes a bunch of handy packages that I have personally worked with. Nothing too flashy, great for beginners.

All the packages mentioned in the `init` file, except some are installed on the first run. The path for certain files like `csharp-mode` need to be changed according to your own system.

### Install Emacs on Windows
http://ftp.gnu.org/gnu/emacs/

### Install Emacs on mac

    brew install emacs
    brew linkapps emacs
### Install Emacs on Ubuntu
    sudo apt-get install emacs

### Configuration
Copy and save the contents of the `init` file to your own `init` file. Change the personal information present in the first two lines to your own. To do so, run the following commands on your Emacs.

This opens up your personal `init.el` file if it exists and creates one if it doesn't.

    C-x C-f ~/.emacs

Paste the contents.

    C-y

Save the File

    C-x C-s

## Some Handy Operations for beginners

Ideally keeps your hands in a touch typing position.

* `C      ` - Shorthand for the ctrl-key
* `M      ` - Shorthand for the meta-key (Alt key)
* `S      ` - Shorthand for the shift-key

Read the tutorial for an extensive guide.

### General

* `C-g    ` -  Quit. Use anytime you make a mistake. Trust me, you will.
* `M-x    ` - Run a command by name
* `C-/    ` - Undo
* `C-x m  ` -  Open magit. It's a magical git interface for emacs

### Files

* `C-x C-f` - Open a file. Starts in the current directory
* `C-x C-s` - Save the current file
* `C-x C-w` - Save as
* `C-x b  ` - Switch to another open file (buffer)
* `C-x C-b` - List all open files (buffers)

My personal variations for `Projectile` package have been mentioned in the `init` file. See those references from there.

### Cut copy and paste

* `C-space` - Start marking stuff. C-g to cancel.
* `C-w    ` - Cut (aka kill)
* `M-w    ` - Copy
* `C-y    ` - Paste (aka yank)

### Navigation

* `C-arrow` - Move past words/paragraphs
* `C-a    ` - Go to start of line
* `C-e    ` - Go to end of line
* `C-s    ` - Search forward.
* `C-r    ` - Search backward.
* `C-v    ` - Scroll down.

### Window management

* `C-x 0  ` - Close this window
* `C-x 1  ` - Close other windows
* `C-x 3  ` - Split window vertically
* `C-x o  ` - Switch between windows

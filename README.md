# Mac Plus App - Bootable Floppy Disk

A classic Macintosh Plus (1986, 1MB) bootable floppy disk application featuring system boot code and utilities for thought mapping with a markdown editor.

## Features

- **Boot Sector**: 68000 assembly code to initialize the Macintosh Plus
- **System Initialization**: Memory management and trap vector setup
- **Resource Fork Handling**: Macintosh resource structure management
- **Markdown Editor**: Thought mapping and note-taking utilities
- **Classic Mac OS**: Authentic 1986 Macintosh Plus experience

## Hardware Requirements

- Macintosh Plus (1MB RAM)
- 3.5" floppy disk drive
- 400KB floppy disk capacity

## Building

```bash
make
```

This generates `mac-plus.img` which can be written to a floppy disk.

## File Structure

- `boot_sector.asm` - Boot initialization code
- `system_init.asm` - System setup routines
- `resource_fork.c` - Resource fork builder
- `Makefile` - Build configuration

## License

MIT License
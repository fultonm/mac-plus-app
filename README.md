# Mac Plus Bootable Disk Workflow

This project builds a Macintosh Plus (1986, 1MB RAM) floppy image by starting from a legally-owned bootable base disk image and preparing a working copy you can customize.

## What "Boot From Disk" Means On A Mac Plus

For a Macintosh Plus, "booting from disk" means the ROM successfully reads a floppy disk that contains a valid Macintosh file system and required System Software files (at minimum `System`, and typically `Finder`), then starts the operating environment from that disk.

On an original Utilities/System disk, this gives you:

- A valid bootable 400K floppy structure.
- A `System Folder` with the files needed by ROM + System Software.
- The Finder/Desktop environment after startup.

If a disk is not bootable, the Mac Plus will not enter Finder from that floppy and will prompt for another startup disk.

## Why This Repo Uses A Base Image

Classic Mac System Software binaries are not included here. Instead, you provide a legally-owned, already-bootable 400K base image (for example, from your own Utilities disk), and this project creates a working copy for customization.

This keeps the project legal and practical while still giving you a repeatable build process.

## Hardware Requirements

- Macintosh Plus (1MB RAM)
- 3.5" floppy disk drive
- 400KB floppy disk capacity

## Building

1. Put your bootable 400K base image at:

```bash
assets/base-bootable-400k.img
```

2. Validate the base image:

```bash
make check-base
```

3. Build a working image copy:

```bash
make
```

This generates `mac-plus.img` (400K) from your base image.

## Adding Applications Later

You can add classic Mac files later using `hfsutils`:

```bash
sudo apt-get update && sudo apt-get install -y hfsutils
make add-apps APP_FILES="path/to/MyApp path/to/MyDeskAccessory"
```

Notes:

- Files must be in a format/toolchain that preserves Macintosh metadata when needed.
- If your app relies on a resource fork, verify packaging before copying.

## File Structure

- `Makefile` - image build and app injection targets
- `assets/base-bootable-400k.img` - your bootable source image (not committed)
- `mac-plus.img` - generated working image
- `boot_sector.asm` - experimental low-level notes (not used by default build)
- `system_init.asm` - experimental low-level notes (not used by default build)
- `resource_fork.c` - placeholder utility source for future tooling

## Devcontainer

The project includes a devcontainer config at `.devcontainer/`.

- `devcontainer.json`: defines the container and post-create setup
- `Dockerfile`: includes `m68k-linux-gnu` cross-toolchain + build tools

Open the folder in VS Code and run "Remote-Containers: Reopen in Container".

## License

MIT License
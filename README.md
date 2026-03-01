# organize-includes

Update `#include` directives in C/C++ source files to use paths relative to each file, and optionally reorder and group includes according to a YAML style.

## Usage

```text
organize-includes -I <includedir> [OPTIONS] sourcefiles...
```

- **-I** *includedir* — Add directory to include search path (repeatable). Required.
- **-r, --recursive** — Scan `-I` directories recursively for includes (default: non-recursive).
- **-J, --include-rec** *includedir* — Add include directory recursively (same as `-I` with `-r`; repeatable).
- **-p, --profile** *FILE* — Load include group profile from YAML. If omitted, a default profile is looked up (see below).
- **-k, --keep-order** — Do not reorder includes (default is to reorder per profile).
- **-n, --relative-name** — Rewrite include paths to be relative to source file (default: only reorder).
- **--dry-run** — Show what would be changed without modifying files.

Include directories are searched in order when resolving quoted includes. By default, includes are grouped and sorted per a profile; use `-p FILE` to force a file or `-k` to leave order unchanged.

## Default profile

When reordering without `-p`, the program looks for a profile file in this order (first existing file wins):

1. **./.includes.yaml** — current working directory  
2. **~/.includes.yaml** — home directory  
3. **~/.config/organize-includes/default.yaml**

Home is `$HOME` on Linux/macOS and `%USERPROFILE%` on Windows. If none exist, the built-in profile is used.

## Profile file (YAML)

Use `-p profile.yaml` to load a specific file. Built-in default angle order: **other-c++** → **famous-c++** → **boost** → **std-c++** → **other-c** → **famous-c** → **glib** → **std-c**. See `example/default.yaml`:

- **quoted_groups** — List of quoted-include group names in order: `samename`, `samedir`, `parentdir`, `other`, `parentdir_other`.
- **angle_groups** — List of angle-include groups (order = output order). Each entry has:
  - **name** — Label (optional).
  - **prefixes** — List of path prefixes (e.g. `wx/`, `boost/`, `glib/`).
  - **match** — One of `no_ext_h`, `std_c_dirs`, `other_cpp`, `other_c`, `other`.

## Dependencies

- Python 3.10+
- **PyYAML** — Required when loading a profile from a file (default search or `-p`). Install with `pip install PyYAML` or the system package `python3-yaml`.

## Changelog

### 0.0.3 (2026-03-01)

- **New option `-r/--recursive`**: Scan `-I` directories recursively to find included files in subdirectories.
- **New option `-J/--include-rec`**: Add include directory with recursive search enabled (equivalent to `-I` with `-r`).
- **New option `-n/--relative-name`**: Rewrite include paths to be relative to each source file's directory. Without this option, only reordering is performed (paths are not changed).
- **Behavior change**: By default, the tool now only reorders includes according to the profile without rewriting paths. Use `-n` to also rewrite paths to be relative.

### 0.0.2 (2026-02-13)

- Added `-v/--verbose`, `-q/--quiet`, `--debug` options
- Log profile in use and scan information
- Fix quoted include search order

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).

# organize-includes

Update `#include` directives in C/C++ source files to use paths relative to each file, and optionally reorder and group includes according to a YAML style.

## Usage

```text
organize-includes -I <includedir> [OPTIONS] sourcefiles...
```

- **-I** *includedir* — Add directory to include search path (repeatable). Required.
- **-p, --profile** *FILE* — Load include group profile from YAML (overrides built-in default).
- **-k, --keep-order** — Do not reorder includes (default is to reorder per profile).
- **--dry-run** — Show what would be changed without modifying files.

Include directories are searched in order when resolving quoted includes. By default, includes are grouped and sorted per the built-in profile; use `-p FILE` to customize or `-k` to leave order unchanged.

## Profile file (YAML)

Use `-p profile.yaml` to customize grouping. Default profile order: **other-c++** → **famous-c++** → **boost** → **std-c++** → **other-c** → **famous-c** → **glib** → **std-c**. See `example/style.yaml`:

- **quoted_groups** — List of quoted-include group names in order: `samename`, `samedir`, `parentdir`, `other`, `parentdir_other`.
- **angle_groups** — List of angle-include groups (order = output order). Each entry has:
  - **name** — Label (optional).
  - **prefixes** — List of path prefixes (e.g. `wx/`, `boost/`, `glib/`).
  - **match** — One of `no_ext_h`, `std_c_dirs`, `other_cpp`, `other_c`, `other`.

## Dependencies

- Python 3.10+
- **PyYAML** — Required only when using `-p/--profile FILE`. Install with `pip install PyYAML` or the system package `python3-yaml`.

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).

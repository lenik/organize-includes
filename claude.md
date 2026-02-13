# organize-includes – notes for AI / Claude

- **Purpose**: Update `#include` paths to be relative to each source file; reorder and group includes per a YAML profile by default.
- **Language**: Python 3.10+.
- **Profile**: Grouping is driven by a profile dict. Default search (when no `-p FILE`): `./.includes.yaml` → `~/.includes.yaml` → `~/.config/organize-includes/default.yaml`, then built-in. Home is `$HOME` (Linux/macOS) or `%USERPROFILE%` (Windows). Profile has `quoted_groups` and `angle_groups`. Use `-k/--keep-order` to disable reordering.
- **Dependencies**: PyYAML when loading any profile file (default search or `-p`).
- **Conventions**: Debian packaging under `debian/`; man page in `organize-includes.1`.

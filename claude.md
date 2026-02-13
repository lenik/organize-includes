# organize-includes – notes for AI / Claude

- **Purpose**: Update `#include` paths to be relative to each source file; reorder and group includes per a YAML profile by default.
- **Language**: Python 3.10+.
- **Profile**: Grouping is driven by a profile dict (built-in default or `-p FILE`). Profile has `quoted_groups` and `angle_groups`. Default angle order: other-c++ > famous-c++ > boost > std-c++ > other-c > famous-c > glib > std-c. Use `-k/--keep-order` to disable reordering.
- **Dependencies**: PyYAML only when using `-p/--profile FILE`.
- **Conventions**: Debian packaging under `debian/`; man page in `organize-includes.1`.

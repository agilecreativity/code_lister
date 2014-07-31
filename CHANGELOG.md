### Changelogs

#### 0.2.1

- Make ruby version 2.1.0+ mandatory

#### 0.2.0

- Update to agile_utils that require refinement suppport (2.0.x+)
- Only support ruby 2.0.x+ to avoid the mokeypatch core ruby library
- Minor update to rubocop style
- Update Guardfile to make it run correctly

#### 0.1.7

- Add new api `files_from_shell` that replaces `prefix` with `.` string

#### 0.1.6

- Add internal api for getting input files from shell command
- Update `agile_utils` to 0.1.14
- Minor code cleanup

#### 0.1.5

- Update the rspec folder structure
- Make CodeLister::files recursive by default
- Minor code cleanup

#### 0.1.4

- Add more tests for 'files_from_command'
- Fix the path to 'Guardfile' to make it pick up the right test

#### 0.1.3

- Add new internal api to get the input files from output of the shell command for advanced usage [New]

#### 0.1.2

- Improve documentation
- Update style for rubocop and update to rubocop 0.23.x

#### 0.1.1

- Simplify the CLI interface
- Fix the style with rubocop
- Use double quote for string

#### 0.1.0

- First release based on [Semantic Versioning][]
- Update the gem dependencies to latest version

#### 0.0.9

- Consistencely replace the `base_dir` with `.` in the result
- Move changelogs section from README.md to CHANGELOGS.md
- Minor code refactoring
- Fix style with rubocop
- Add rubocop gem and simple rules

#### 0.0.8

- Update dependencies

#### 0.0.7

- Make use of the 'agile_utils' gem for better code re-use

#### 0.0.6

- Add `--non-exts` option that make it possible to include files without extension.

#### 0.0.5

- Refactoring the CLI options to make it easy for re-use in other library.

#### 0.0.4

- Add `ignore-case` option
- Use `-n' for `--include-words` and use `-i` for `--ignore-case`.
- Make the `--recursive` the default option
- Make the `--ignore-case` the default option

#### 0.0.3

- Update README.md to include better sample usage, and misc cleanup.

#### 0.0.2

- initial release

[Semantic Versioning]: http://semver.org

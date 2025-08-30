# awsp

A handy script to switch/manage different AWS profiles from the CLI.

Arguments:

- (none): Prints the current profile and its SSO status. If inactive, copies the login command to your paste buffer for convenience.
- (name of profile): Sets `$AWS_PROFILE` to the profile, and checks SSO status as described above.
- `ls` or `list`: Lists AWS profiles the user has configured in the CLI along with their SSO statuses.
- `clear`: Unsets `$AWS_PROFILE`.

If running on Linux, change `pbcopy` to `xclip -selection clipboard` and `sysctl -n hw.ncpu` to `nproc`.

Requires the AWS CLI to be installed (obviously).

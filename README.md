# awsp

A handy script to switch/manage different AWS profiles from the CLI. Requires the [AWS CLI](https://aws.amazon.com/cli/) to be installed (obviously).

Arguments:

- (none): Prints the current profile and its SSO status. If inactive, copies the login command to your paste buffer for convenience.
- (name of profile): Sets `$AWS_PROFILE` to the profile, and checks SSO status as described above.
- `ls` or `list`: Lists AWS profiles the user has configured in the CLI along with their SSO statuses.
- `clear`: Unsets `$AWS_PROFILE`.

It's recommended to add the alias `alias awsp='. ~/path/to/awsp/awsp.sh'` to your bashrc, zshrc, etc. to easily run the script.

> [!NOTE]
> When pulling SSO statuses in `awsp ls`, the script defaults to using the number of available cores as the concurrency limit. This can be overridden by setting the `AWSP_CONCURRENCY` environment variable to whatever value you want.

> [!NOTE]
> If running on Linux, change `pbcopy` to `xclip -selection clipboard` and `sysctl -n hw.ncpu` to `nproc`.

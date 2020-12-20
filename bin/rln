#!/home/alex/.venvs/env-rln/bin/python

import subprocess
import click
import click_option_group


@click.command()
@click.argument("src", type=click.Path(exists=True, resolve_path=True))
@click.argument("dest", type=click.Path(resolve_path=True))
@click.option("-f", "--force", is_flag=True, required=False)
@click_option_group.optgroup.group(
    "Link type", cls=click_option_group.RequiredMutuallyExclusiveOptionGroup
)
@click_option_group.optgroup.option("-h", "--hard", is_flag=True)
@click_option_group.optgroup.option("-s", "--soft", is_flag=True)
def cli(src, dest, force, hard, soft):
    options = [
        x
        for x in [
            "ln",
            "-s" if soft else None,
            src,
            dest,
            "--force" if force else None,
        ]
        if x is not None
    ]
    subprocess.run(options)


if __name__ == "__main__":
    cli()

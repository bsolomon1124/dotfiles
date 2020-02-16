#!/usr/bin/env python

from __future__ import print_function

from itertools import groupby


def minor_version(version):
    return ".".join(version.split(".")[:2])


def most_recent_minor_versions(versions):
    grp = groupby(
        map(str.strip, versions.strip().split("\n")),
        key=minor_version
    )
    for _, g in grp:
        print(list(g)[-1])


if __name__ == "__main__":
    import sys

    most_recent_minor_versions(sys.stdin.read())


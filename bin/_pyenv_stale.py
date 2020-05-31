#!/usr/bin/env python

from __future__ import print_function

from itertools import groupby


def minor_version(version):
    return ".".join(version.split(".")[:2])


def stale_minor_versions(versions):
    grp = groupby(
        map(str.strip, versions.strip().split("\n")),
        key=minor_version
    )
    for _, g in grp:
        v = list(g)
        if len(v) > 1:
            for i in v[:-1]:
                print(i)


if __name__ == "__main__":
    import sys

    stale_minor_versions(sys.stdin.read())

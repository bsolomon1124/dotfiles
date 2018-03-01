"""IPython startup file.  Place in ~/.ipython/profile_default/startup/"""

import os
import sys

import numpy as np
import pandas as pd

from IPython import get_ipython


def startup():

    try:
        os.chdir('/Users/brad/Scripts/python/')
    except FileNotFoundError:
        print('Defaulting to %s' % os.getcwd())

    # Create some IPython aliases.  See http://bit.ly/2HUcUe7
    magic = get_ipython().magic
    sys.stdout = open(os.devnull, 'w')
    magic('%alias_magic -p "-n 750 -r 15" ctime timeit')
    magic('%alias_magic -p "-oq -n 750 -r 15" timeobj timeit')
    sys.stdout = sys.__stdout__

    # pandas options & settings - for full list and defaults:
    # https://pandas.pydata.org/pandas-docs/stable/options.html#available-options
    # Reference by full path here to avoid regex conflict with options
    #     added in the future.
    # Skipped here: 'html', 'io', & 'compute'.

    options = {
        'display': {
            'max_columns': None,
            'max_colwidth': 20,
            'expand_frame_repr': False,
            'max_rows': 25,
            'max_seq_items': 50,
            'precision': 4,
            'show_dimensions': False
            },
        'mode': {
            'chained_assignment': None
            }
        }

    for category, option in options.items():
        for op, value in option.items():
            pd.set_option('{0}.{1}'.format(category, op), value)

    # NumPy print options
    # `suppress`:
    # - False: x**2 - (x + eps)**2 --> array([ -4.930e-32,  -4.440e-16, ...
    # - True: x**2 - (x + eps)**2 --> array([-0., -0.,  0.,  0.])
    # Defaults:
    # np.set_printoptions(edgeitems=3, infstr='inf',
    #     linewidth=75, nanstr='nan', precision=8,
    #     suppress=False, threshold=1000, formatter=None)

    np.set_printoptions(
        precision=4,
        threshold=625,
        edgeitems=10,
        )


if __name__ == '__main__':
    startup()
    del startup, __doc__, get_ipython

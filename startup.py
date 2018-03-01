"""IPython startup file.  Place in .ipython/profile_default/startup/"""

import os

import matplotlib as mpl  # NOQA
import matplotlib.pyplot as plt  # NOQA
import numpy as np
import pandas as pd
import scipy.stats as scs  # NOQA


def startup():

    # Just a convenience msg on startup: "Namespace: os, plt, np, pd, scs"
    excl = ('In', 'Out', 'get_ipython', 'exit', 'quit', 'excl', 'startup')
    imports = [key for key in globals().copy() if not key.startswith('_')
               and key not in excl]
    print('Namespace:', ', '.join(imports))

    try:
        os.chdir(os.path.expanduser('~') + '/Scripts/python')
    except FileNotFoundError:
        pass
    print('Current directory:', os.getcwd())

    # Create some IPython aliases.  See
    # http://ipython.readthedocs.io/en/stable/interactive/magics.html#magic-alias_magic # noqa
    from IPython import get_ipython
    magic = get_ipython().magic
    # Custom %timeit for more complex functions
    magic('%alias_magic -p "-n 750 -r 15" ctime timeit')
    # A TimeitResult object with output suppressed i.e. res = %timeobj f()
    magic('%alias_magic -p "-oq -n 750 -r 15" timeobj timeit')

    # Figsize is specified in `matplotlibrc` file as (8, 5) but
    #     reverts back to (6, 4) in Jupyter QtConsole (but not IPython),
    #     presumably because of backend.  Set manually here.
    mpl.rcParams['figure.figsize'] = [8.0, 5.0]

    # pandas options -------------------------------------------------------
    # For full list and defaults:
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

    # NumPy print options --------------------------------------------------
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
    del startup, __doc__
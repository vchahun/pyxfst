# Cython XFST bindings

To install, get the XFST library from http://www.fsmbook.com and copy the dynamic library to `/usr/local/lib` or add its path to the `(DY)LD_LIBRARY_PATH` environment variable.

Then compile the python extension by specifying the path of the XFST API with the `XFSM` environment variable:

    XFSM=/path/to/xfsm_api python setup.py install

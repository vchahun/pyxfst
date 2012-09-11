import sys,os
from distutils.core import setup
from distutils.extension import Extension

def fail(msg):
    sys.stderr.write(msg+'\n')
    sys.exit(1)

if not 'XFSM' in os.environ:
    fail('Please set the XFSM environment variable to the path of the XFST API')
XFSM = os.environ['XFSM']
INC = os.path.join(XFSM, 'include')
if not os.path.exists(INC):
    fail('Cannot determine the path of the XFSM headers')
lib_path = set(os.listdir(XFSM)) - set(('doc', 'include', 'Makefile', 'src'))
if not len(lib_path) == 1:
    fail('Cannot determine the path of the XFSM library [arch]')
LIB = os.path.join(XFSM, next(iter(lib_path)), 'lib')
if not os.path.exists(LIB):
    fail('Cannot determine the path of the XFSM library [lib:%s]')

ext_modules = [
    Extension(name='xfst',
        sources=['xfst.c'],
        include_dirs=[INC],
        library_dirs=[LIB],
        libraries=['xfsm']) 
        #extra_compile_args=['-O3'],
        #extra_link_args=['-Wl,-rpath,'+LIB])
]

setup(
    name='xfst',
    ext_modules=ext_modules
)

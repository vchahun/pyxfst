cdef FST_CNTXTptr* _CTX = initialize_cfsm()

cdef fail_if_null(void* ptr, char* msg):
    if ptr == NULL: raise Exception(msg)

cdef bytes as_str(word):
    if isinstance(word, bytes):
        return word
    elif isinstance(word, unicode):
        return word.encode('utf8')
    raise TypeError('expected string and not {0}'.format(type(word)))

def read_binary(filename):
    return FSM(as_str(filename))

cdef class FSM:
    cdef NETptr* net

    def __cinit__(self, char* binary):
        self.net = load_net(binary, _CTX)
        if not self.net:
            raise IOError('cannot read binary FSM {0}'.format(binary))

    def __dealloc__(self):
        free_network(self.net)

    def apply_up(self, inp):
        inp = as_str(inp)
        cdef APPLYptr* applyer = init_apply(self.net, LOWER, _CTX)
        fail_if_null(applyer, 'cannot create applyer')
        cdef char* res = apply_to_string(inp, applyer)
        fail_if_null(res, 'empty result')
        try:
            for analysis in res.split('\n')[:-1]:
                yield unicode(analysis, 'utf8')
        finally:
            free_applyer(applyer)

    def apply_down(self, inp):
        inp = as_str(inp)
        cdef APPLYptr* applyer = init_apply(self.net, UPPER, _CTX)
        fail_if_null(applyer, 'cannot create applyer')
        cdef char* res = apply_to_string(inp, applyer)
        fail_if_null(res, 'empty result')
        try:
            for analysis in res.split('\n')[:-1]:
                yield unicode(analysis, 'utf8')
        finally:
            free_applyer(applyer)

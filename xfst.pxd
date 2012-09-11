cdef extern from *:
    ctypedef char const_char "const char"

cdef extern from "xfsm_api.h":
    cdef struct FST_CNTXTptr:
        pass
    
    cdef struct NETptr:
        pass

    cdef struct APPLYptr:
        pass

    cdef enum symbol_pair:
        UPPER, LOWER, BOTH_SIDES

    cdef FST_CNTXTptr *initialize_cfsm()
    cdef NETptr *load_net(const_char *filename, FST_CNTXTptr *fst_cntxt)
    void free_network(NETptr *net)
    cdef APPLYptr *init_apply(NETptr *net, int side, FST_CNTXTptr *fst_cntxt)
    void free_applyer(APPLYptr *applyer)
    char *apply_to_string(const_char *input, APPLYptr *applyer)

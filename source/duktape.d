import std.c.stdarg;
import std.string;
import std.stdint;

enum DUK_VERSION = 10100L;

/* Basic types */
alias duk_int_t   = int;
alias duk_uint_t  = uint;
alias duk_size_t  = size_t;
alias duk_double_t = double;
alias duk_errcode_t = duk_int_t;
alias duk_idx_t = duk_int_t;
alias duk_uarridx_t = duk_uint_t;
alias duk_small_int_t = int;
alias duk_bool_t = duk_small_int_t;
alias duk_ret_t = duk_small_int_t;
alias duk_codepoint_t = duk_int_t;
alias duk_ucodepoint_t = duk_uint_t;

alias duk_uint16_t = uint16_t;
alias duk_int32_t =  int32_t;
alias duk_uint32_t = uint32_t;

/* Stack type */
/* Value types, used by e.g. duk_get_type() */
enum DUK_TYPE_NONE =                     0;    /* no value, e.g. invalid index */
enum DUK_TYPE_UNDEFINED =                1;    /* Ecmascript undefined */
enum DUK_TYPE_NULL =                     2;    /* Ecmascript null */
enum DUK_TYPE_BOOLEAN =                  3;    /* Ecmascript boolean: 0 or 1 */
enum DUK_TYPE_NUMBER =                   4;    /* Ecmascript number: double */
enum DUK_TYPE_STRING =                   5;    /* Ecmascript string: CESU-8 / extended UTF-8 encoded */
enum DUK_TYPE_OBJECT =                   6;    /* Ecmascript object: includes objects, arrays, functions, threads */
enum DUK_TYPE_BUFFER =                   7;    /* fixed or dynamic, garbage collected byte buffer */
enum DUK_TYPE_POINTER =                  8;    /* raw void pointer */
enum DUK_TYPE_LIGHTFUNC =                9;    /* lightweight function pointer */

/* Value mask types, used by e.g. duk_get_type_mask() */
enum DUK_TYPE_MASK_NONE =                (1 << DUK_TYPE_NONE);
enum DUK_TYPE_MASK_UNDEFINED =           (1 << DUK_TYPE_UNDEFINED);
enum DUK_TYPE_MASK_NULL =                (1 << DUK_TYPE_NULL);
enum DUK_TYPE_MASK_BOOLEAN =             (1 << DUK_TYPE_BOOLEAN);
enum DUK_TYPE_MASK_NUMBER =              (1 << DUK_TYPE_NUMBER);
enum DUK_TYPE_MASK_STRING =              (1 << DUK_TYPE_STRING);
enum DUK_TYPE_MASK_OBJECT =              (1 << DUK_TYPE_OBJECT);
enum DUK_TYPE_MASK_BUFFER =              (1 << DUK_TYPE_BUFFER);
enum DUK_TYPE_MASK_POINTER =             (1 << DUK_TYPE_POINTER);
enum DUK_TYPE_MASK_LIGHTFUNC =           (1 << DUK_TYPE_LIGHTFUNC);
enum DUK_TYPE_MASK_THROW =               (1 << 10);  /* internal flag value: throw if mask doesn't match */

/* Structs and typedefs */
struct duk_context;

extern(C) {
    alias duk_c_function = duk_ret_t function(duk_context *ctx);
    alias duk_alloc_function = void *function(void *udata, duk_size_t size);
    alias duk_realloc_function = void *function(void *udata, void *ptr, duk_size_t size);
    alias duk_free_function = void function(void *udata, void *ptr);
    alias duk_fatal_function = void function(duk_context *ctx, duk_errcode_t code, const char *msg);
    alias duk_decode_char_function = void function(void *udata, duk_codepoint_t codepoint);
    alias duk_map_char_function = duk_codepoint_t function(void *udata, duk_codepoint_t codepoint);
    alias duk_safe_call_function = duk_ret_t function(duk_context *ctx);
}

struct duk_memory_functions {
    duk_alloc_function alloc_func;
    duk_realloc_function realloc_func;
    duk_free_function free_func;
    void *udata;
};

struct duk_function_list_entry {
    const char *key;
    duk_c_function value;
    duk_int_t nargs;
};

struct duk_number_list_entry {
    const char *key;
    duk_double_t value;
};

/* Error codes */
/* Internal error codes */
enum DUK_ERR_NONE =                 0;    /* no error (e.g. from duk_get_error_code()) */
enum DUK_ERR_UNIMPLEMENTED_ERROR =  50;   /* UnimplementedError */
enum DUK_ERR_UNSUPPORTED_ERROR =    51;   /* UnsupportedError */
enum DUK_ERR_INTERNAL_ERROR =       52;   /* InternalError */
enum DUK_ERR_ALLOC_ERROR =          53;   /* AllocError */
enum DUK_ERR_ASSERTION_ERROR =      54;   /* AssertionError */
enum DUK_ERR_API_ERROR =            55;   /* APIError */
enum DUK_ERR_UNCAUGHT_ERROR =       56;   /* UncaughtError */

/* Return codes from Duktape/C functions */
/* Ecmascript E5 specification error codes */
enum DUK_ERR_ERROR =                100;  /* Error */
enum DUK_ERR_EVAL_ERROR =           101;  /* EvalError */
enum DUK_ERR_RANGE_ERROR =          102;  /* RangeError */
enum DUK_ERR_REFERENCE_ERROR =      103;  /* ReferenceError */
enum DUK_ERR_SYNTAX_ERROR =         104;  /* SyntaxError */
enum DUK_ERR_TYPE_ERROR =           105;  /* TypeError */
enum DUK_ERR_URI_ERROR =            106;  /* URIError */

/* Return codes for C functions */
enum DUK_RET_UNIMPLEMENTED_ERROR =  (-DUK_ERR_UNIMPLEMENTED_ERROR);
enum DUK_RET_UNSUPPORTED_ERROR =    (-DUK_ERR_UNSUPPORTED_ERROR);
enum DUK_RET_INTERNAL_ERROR =       (-DUK_ERR_INTERNAL_ERROR);
enum DUK_RET_ALLOC_ERROR =          (-DUK_ERR_ALLOC_ERROR);
enum DUK_RET_ASSERTION_ERROR =      (-DUK_ERR_ASSERTION_ERROR);
enum DUK_RET_API_ERROR =            (-DUK_ERR_API_ERROR);
enum DUK_RET_UNCAUGHT_ERROR =       (-DUK_ERR_UNCAUGHT_ERROR);
enum DUK_RET_ERROR =                (-DUK_ERR_ERROR);
enum DUK_RET_EVAL_ERROR =           (-DUK_ERR_EVAL_ERROR);
enum DUK_RET_RANGE_ERROR =          (-DUK_ERR_RANGE_ERROR);
enum DUK_RET_REFERENCE_ERROR =      (-DUK_ERR_REFERENCE_ERROR);
enum DUK_RET_SYNTAX_ERROR =         (-DUK_ERR_SYNTAX_ERROR);
enum DUK_RET_TYPE_ERROR =           (-DUK_ERR_TYPE_ERROR);
enum DUK_RET_URI_ERROR =            (-DUK_ERR_URI_ERROR);

/* Return codes for protected calls (duk_safe_call(), duk_pcall()). */
enum DUK_EXEC_SUCCESS =             0;
enum DUK_EXEC_ERROR =               1;

/* Compilation flags for duk_compile() and duk_eval() */
enum DUK_COMPILE_EVAL =                  (1 << 0);    /* compile eval code (instead of program) */
enum DUK_COMPILE_FUNCTION =              (1 << 1);    /* compile function code (instead of program) */
enum DUK_COMPILE_STRICT =                (1 << 2);    /* use strict (outer) context for program, eval, or function */
enum DUK_COMPILE_SAFE =                  (1 << 3);    /* (internal) catch compilation errors */
enum DUK_COMPILE_NORESULT =              (1 << 4);    /* (internal) omit eval result */
enum DUK_COMPILE_NOSOURCE =              (1 << 5);    /* (internal) no source string on stack */
enum DUK_COMPILE_STRLEN =                (1 << 6);    /* (internal) take strlen() of src_buffer (avoids double evaluation in macro) */

/* Flags for duk_def_prop() and its variants */
enum DUK_DEFPROP_WRITABLE =              (1 << 0);    /* set writable (effective if DUK_DEFPROP_HAVE_WRITABLE set) */
enum DUK_DEFPROP_ENUMERABLE =            (1 << 1);    /* set enumerable (effective if DUK_DEFPROP_HAVE_ENUMERABLE set) */
enum DUK_DEFPROP_CONFIGURABLE =          (1 << 2);    /* set configurable (effective if DUK_DEFPROP_HAVE_CONFIGURABLE set) */
enum DUK_DEFPROP_HAVE_WRITABLE =         (1 << 3);    /* set/clear writable */
enum DUK_DEFPROP_HAVE_ENUMERABLE =       (1 << 4);    /* set/clear enumerable */
enum DUK_DEFPROP_HAVE_CONFIGURABLE =     (1 << 5);    /* set/clear configurable */
enum DUK_DEFPROP_HAVE_VALUE =            (1 << 6);    /* set value (given on value stack) */
enum DUK_DEFPROP_HAVE_GETTER =           (1 << 7);    /* set getter (given on value stack) */
enum DUK_DEFPROP_HAVE_SETTER =           (1 << 8);    /* set setter (given on value stack) */
enum DUK_DEFPROP_FORCE =                 (1 << 9);    /* force change if possible, may still fail for e.g. virtual properties */

/* Enumeration flags for duk_enum() */
enum DUK_ENUM_INCLUDE_NONENUMERABLE =    (1 << 0);    /* enumerate non-numerable properties in addition to enumerable */
enum DUK_ENUM_INCLUDE_INTERNAL =         (1 << 1);    /* enumerate internal properties (regardless of enumerability) */
enum DUK_ENUM_OWN_PROPERTIES_ONLY =      (1 << 2);    /* don't walk prototype chain, only check own properties */
enum DUK_ENUM_ARRAY_INDICES_ONLY =       (1 << 3);    /* only enumerate array indices */
enum DUK_ENUM_SORT_ARRAY_INDICES =       (1 << 4);    /* sort array indices, use with DUK_ENUM_ARRAY_INDICES_ONLY */
enum DUK_ENUM_NO_PROXY_BEHAVIOR =        (1 << 5);    /* enumerate a proxy object itself without invoking proxy behavior */

/* Coercion hints */
enum DUK_HINT_NONE =         0;    /* prefer number, unless coercion input is a Date, in which case prefer string (E5 Section 8.12.8) */
enum DUK_HINT_STRING =       1;    /* prefer string */
enum DUK_HINT_NUMBER =       2;    /* prefer number */

/* Flags for duk_push_thread_raw() */
enum DUK_THREAD_NEW_GLOBAL_ENV =         (1 << 0);    /* create a new global environment */

/* Flags for duk_push_string_file_raw() */
enum DUK_STRING_PUSH_SAFE =              (1 << 0);    /* no error if file does not exist */

/* Log levels */
enum DUK_LOG_TRACE =                    0;
enum DUK_LOG_DEBUG =                    1;
enum DUK_LOG_INFO =                     2;
enum DUK_LOG_WARN =                     3;
enum DUK_LOG_ERROR =                    4;
enum DUK_LOG_FATAL =                    5;

/* Misc defines */
enum DUK_INT_MIN =           int.min;
enum DUK_INT_MAX =           int.max;
enum DUK_IDX_MIN =           DUK_INT_MIN;
enum DUK_IDX_MAX =           DUK_INT_MAX;

enum DUK_INVALID_INDEX =     DUK_IDX_MIN;

enum DUK_VARARGS =           (cast(duk_int_t) (-1));

enum DUK_API_ENTRY_STACK =   64;

/* Macros */

/*
 *  Context management
 */

duk_context *duk_create_heap_default() {
    return duk_create_heap(null, null, null, null, null);
}

/*
 *  Push operations
 */

void *duk_push_buffer(duk_context *ctx, duk_size_t size, duk_bool_t dynamic) {
    return duk_push_buffer_raw(ctx, size, dynamic);
}

void *duk_push_fixed_buffer(duk_context *ctx, duk_size_t size) {
    return duk_push_buffer_raw(ctx, size, 0 /*dynamic*/);
}

void *duk_push_dynamic_buffer(duk_context *ctx, duk_size_t size) {
    return duk_push_buffer_raw(ctx, size, 1 /*dynamic*/);
}

duk_idx_t duk_push_error_object(duk_context *ctx, duk_errcode_t err_code, const char *fmt, ...) {
    va_list ap;

    version (X86)
        va_start(ap, fmt);
    else
    version (Win64)
        va_start(ap, fmt);
    else
    version (X86_64)
        va_start(ap, __va_argsave);
    else
    static assert(0, "Platform not supported.");

    auto r =  duk_push_error_object_raw(ctx, err_code, toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return r;
}

duk_idx_t duk_push_error_object_va(duk_context *ctx, duk_errcode_t err_code, const char *fmt, va_list ap) {
    return duk_push_error_object_va_raw(ctx, err_code, toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);
}

const(char) *duk_push_string_file(duk_context *ctx, const char *path) {
    return duk_push_string_file_raw(ctx, path, 0);
}

duk_idx_t duk_push_thread(duk_context *ctx) {
    return duk_push_thread_raw(ctx, 0 /*flags*/);
}

duk_idx_t duk_push_thread_new_globalenv(duk_context *ctx) {
    return duk_push_thread_raw(ctx, DUK_THREAD_NEW_GLOBAL_ENV /*flags*/);
}

/*
 *  Error handling
 */
void duk_error(duk_context *ctx, duk_errcode_t err_code, const char *fmt, ...) {
    va_list ap;

    version (X86)
        va_start(ap, fmt);
    else
    version (Win64)
        va_start(ap, fmt);
    else
    version (X86_64)
        va_start(ap, __va_argsave);
    else
    static assert(0, "Platform not supported.");

    duk_error_raw(ctx, cast(duk_errcode_t)err_code, toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);
}

void duk_error_va(duk_context *ctx, duk_errcode_t err_code, const char *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)err_code, toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);
}

/*
 *  Stack manipulation (other than push/pop)
 */
void duk_xmove_top(duk_context *to_ctx, duk_context *from_ctx, duk_idx_t count) {
    duk_xcopymove_raw(to_ctx, from_ctx, count, 0 /*is_copy*/);
}

void duk_xcopy_top(duk_context *to_ctx, duk_context *from_ctx, duk_idx_t count) {
    duk_xcopymove_raw(to_ctx, from_ctx, count, 1 /*is_copy*/);
}

/*
 *  Type checks
 *
 *  duk_is_none(), which would indicate whether index it outside of stack,
 *  is not needed; duk_is_valid_index() gives the same information.
 */
duk_bool_t duk_is_object_coercible(duk_context *ctx, duk_idx_t index) {
    return duk_check_type_mask(ctx, index, DUK_TYPE_MASK_BOOLEAN |
                                           DUK_TYPE_MASK_NUMBER |
                                           DUK_TYPE_MASK_STRING |
                                           DUK_TYPE_MASK_OBJECT |
                                           DUK_TYPE_MASK_BUFFER |
                                           DUK_TYPE_MASK_POINTER |
                                           DUK_TYPE_MASK_LIGHTFUNC);
}

duk_bool_t duk_is_error(duk_context *ctx, duk_idx_t index) {
    return duk_get_error_code(ctx, index) != 0;
}

/*
 *  Require operations: no coercion, throw error if index or type
 *  is incorrect.  No defaulting.
 */
void duk_require_type_mask(duk_context *ctx, duk_idx_t index, duk_uint_t mask) {
    duk_check_type_mask(ctx, index, mask | DUK_TYPE_MASK_THROW);
}

void duk_require_object_coercible(duk_context *ctx, duk_idx_t index) {
    duk_check_type_mask(ctx, index, DUK_TYPE_MASK_BOOLEAN |
                                    DUK_TYPE_MASK_NUMBER |
                                    DUK_TYPE_MASK_STRING |
                                    DUK_TYPE_MASK_OBJECT |
                                    DUK_TYPE_MASK_BUFFER |
                                    DUK_TYPE_MASK_POINTER |
                                    DUK_TYPE_MASK_LIGHTFUNC |
                                    DUK_TYPE_MASK_THROW);
}

/*
 *  Coercion operations: in-place coercion, return coerced value where
 *  applicable.  If index is invalid, throw error.  Some coercions may
 *  throw an expected error (e.g. from a toString() or valueOf() call)
 *  or an internal error (e.g. from out of memory).
 */
enum DUK_BUF_MODE_FIXED =     0;   /* internal: request fixed buffer result */
enum DUK_BUF_MODE_DYNAMIC =   1;   /* internal: request dynamic buffer result */
enum DUK_BUF_MODE_DONTCARE =  2;   /* internal: don't care about fixed/dynamic nature */

void *duk_to_buffer(duk_context *ctx, duk_idx_t index, duk_size_t *out_size) {
    return duk_to_buffer_raw(ctx, index, out_size, DUK_BUF_MODE_DONTCARE);
}

void *duk_to_fixed_buffer(duk_context *ctx, duk_idx_t index, duk_size_t *out_size) {
    return duk_to_buffer_raw(ctx, index, out_size, DUK_BUF_MODE_FIXED);
}

void *duk_to_dynamic_buffer(duk_context *ctx, duk_idx_t index, duk_size_t *out_size) {
    return duk_to_buffer_raw(ctx, index, out_size, DUK_BUF_MODE_DYNAMIC);
}

/* safe variants of a few coercion operations */
const(char) *duk_safe_to_string(duk_context *ctx, duk_idx_t index) {
    return duk_safe_to_lstring(ctx, index, null);
}

/*
 *  Compilation and evaluation
 */
/* plain */
void duk_eval(duk_context *ctx) {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL);
}

void duk_eval_noresult(duk_context *ctx) {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_NORESULT);
}

duk_int_t duk_peval(duk_context *ctx) {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE);
}

duk_int_t duk_peval_noresult(duk_context *ctx) {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NORESULT);
}

void duk_compile(duk_context *ctx, duk_uint_t flags) {
    duk_compile_raw(ctx, null, 0, flags);
}

duk_int_t duk_pcompile(duk_context *ctx, duk_uint_t flags) {
    return duk_compile_raw(ctx, null, 0, flags | DUK_COMPILE_SAFE);
}

/* string */
void duk_eval_string(duk_context *ctx, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, src, 0, DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

void duk_eval_string_noresult(duk_context *ctx, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, src, 0, DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NORESULT);
}

duk_int_t duk_peval_string(duk_context *ctx, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, src, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

duk_int_t duk_peval_string_noresult(duk_context *ctx, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, src, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NORESULT);
}

void duk_compile_string(duk_context *ctx, duk_uint_t flags, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_compile_raw(ctx, src, 0, flags | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

void duk_compile_string_filename(duk_context *ctx, duk_uint_t flags, const char *src) {
    duk_compile_raw(ctx, src, 0, flags | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

duk_int_t duk_pcompile_string(duk_context *ctx, duk_uint_t flags, const char *src) {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_compile_raw(ctx, src, 0, flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

duk_int_t duk_pcompile_string_filename(duk_context *ctx, duk_uint_t flags, const char *src) {
    return duk_compile_raw(ctx, src, 0, flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

/* lstring */
void duk_eval_lstring(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, buf, len, DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE);
}

void duk_eval_lstring_noresult(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_eval_raw(ctx, buf, len, DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NORESULT);
}

duk_int_t duk_peval_lstring(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, buf, len, DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_SAFE);
}

duk_int_t duk_peval_lstring_noresult(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_eval_raw(ctx, buf, len, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NORESULT);
}

void duk_compile_lstring(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    duk_compile_raw(ctx, buf, len, flags | DUK_COMPILE_NOSOURCE);
}

void duk_compile_lstring_filename(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    duk_compile_raw(ctx, buf, len, flags | DUK_COMPILE_NOSOURCE);
}

duk_int_t duk_pcompile_lstring(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    duk_push_string(ctx, toStringz(__FILE__));
    return duk_compile_raw(ctx, buf, len, flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE);
}

duk_int_t duk_pcompile_lstring_filename(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    return duk_compile_raw(ctx, buf, len, flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE);
}

/* file */
void duk_eval_file(duk_context *ctx, const char *path) {
    duk_push_string_file_raw(ctx, path, 0);
    duk_push_string(ctx, path);
    duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL);
}

void duk_eval_file_noresult(duk_context *ctx, const char *path) {
    duk_push_string_file_raw(ctx, path, 0);
    duk_push_string(ctx, path);
    duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_NORESULT);
}

duk_int_t duk_peval_file(duk_context *ctx, const char *path) {
    duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
    duk_push_string(ctx, path);
    return duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE);
}

duk_int_t duk_peval_file_noresult(duk_context *ctx, const char *path) {
    duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
    duk_push_string(ctx, path);
    return duk_eval_raw(ctx, null, 0, DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NORESULT);
}

void duk_compile_file(duk_context *ctx, duk_uint_t flags, const char *path) {
    duk_push_string_file_raw(ctx, path, 0);
    duk_push_string(ctx, path);
    duk_compile_raw(ctx, null, 0, flags);
}

duk_int_t duk_pcompile_file(duk_context *ctx, duk_uint_t flags, const char *path) {
    duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
    duk_push_string(ctx, path);
    return duk_compile_raw(ctx, null, 0, flags | DUK_COMPILE_SAFE);
}

extern (C) {
    void *duk_alloc(duk_context *ctx, duk_size_t size);
    void *duk_alloc_raw(duk_context *ctx, duk_size_t size);
    void duk_base64_decode(duk_context *ctx, duk_idx_t index);
    const(char) *duk_base64_encode(duk_context *ctx, duk_idx_t index);
    void duk_call(duk_context *ctx, duk_idx_t nargs);
    void duk_call_method(duk_context *ctx, duk_idx_t nargs);
    void duk_call_prop(duk_context *ctx, duk_idx_t obj_index, duk_idx_t nargs);
    duk_codepoint_t duk_char_code_at(duk_context *ctx, duk_idx_t index, duk_size_t char_offset);
    duk_bool_t duk_check_stack(duk_context *ctx, duk_idx_t extra);
    duk_bool_t duk_check_stack_top(duk_context *ctx, duk_idx_t top);
    duk_bool_t duk_check_type(duk_context *ctx, duk_idx_t index, duk_int_t type);
    duk_bool_t duk_check_type_mask(duk_context *ctx, duk_idx_t index, duk_uint_t mask);
    void duk_compact(duk_context *ctx, duk_idx_t obj_index);
    duk_int_t duk_compile_raw(duk_context *ctx, const char *src_buffer, duk_size_t src_length, duk_uint_t flags);
    void duk_concat(duk_context *ctx, duk_idx_t count);
    void duk_copy(duk_context *ctx, duk_idx_t from_index, duk_idx_t to_index);
    duk_context *duk_create_heap(duk_alloc_function alloc_func,
                                 duk_realloc_function realloc_func,
                                 duk_free_function free_func,
                                 void *heap_udata,
                                 duk_fatal_function fatal_handler);
    void duk_decode_string(duk_context *ctx, duk_idx_t index, duk_decode_char_function callback, void *udata);
    void duk_def_prop(duk_context *ctx, duk_idx_t obj_index, duk_uint_t flags);
    duk_bool_t duk_del_prop(duk_context *ctx, duk_idx_t obj_index);
    duk_bool_t duk_del_prop_index(duk_context *ctx, duk_idx_t obj_index, duk_uarridx_t arr_index);
    duk_bool_t duk_del_prop_string(duk_context *ctx, duk_idx_t obj_index, const char *key);
    void duk_destroy_heap(duk_context *ctx);
    void duk_dump_context_stderr(duk_context *ctx);
    void duk_dump_context_stdout(duk_context *ctx);
    void duk_dup(duk_context *ctx, duk_idx_t from_index);
    void duk_dup_top(duk_context *ctx);
    void duk_enum(duk_context *ctx, duk_idx_t obj_index, duk_uint_t enum_flags);
    duk_bool_t duk_equals(duk_context *ctx, duk_idx_t index1, duk_idx_t index2);
    void duk_error_raw(duk_context *ctx, duk_errcode_t err_code, const char *filename, duk_int_t line, const char *fmt, ...);
    void duk_error_va_raw(duk_context *ctx, duk_errcode_t err_code, const char *filename, duk_int_t line, const char *fmt, va_list ap);
    duk_int_t duk_eval_raw(duk_context *ctx, const char *src_buffer, duk_size_t src_length, duk_uint_t flags);
    void duk_fatal(duk_context *ctx, duk_errcode_t err_code, const char *err_msg);
    void duk_free(duk_context *ctx, void *ptr);
    void duk_free_raw(duk_context *ctx, void *ptr);
    void duk_gc(duk_context *ctx, duk_uint_t flags);
    duk_bool_t duk_get_boolean(duk_context *ctx, duk_idx_t index);
    void *duk_get_buffer(duk_context *ctx, duk_idx_t index, duk_size_t *out_size);
    duk_c_function duk_get_c_function(duk_context *ctx, duk_idx_t index);
    duk_context *duk_get_context(duk_context *ctx, duk_idx_t index);
    duk_int_t duk_get_current_magic(duk_context *ctx);
    duk_errcode_t duk_get_error_code(duk_context *ctx, duk_idx_t index);
    void duk_get_finalizer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_get_global_string(duk_context *ctx, const char *key);
    void *duk_get_heapptr(duk_context *ctx, duk_idx_t index);
    duk_int_t duk_get_int(duk_context *ctx, duk_idx_t index);
    duk_size_t duk_get_length(duk_context *ctx, duk_idx_t index);
    const(char) *duk_get_lstring(duk_context *ctx, duk_idx_t index, duk_size_t *out_len);
    duk_int_t duk_get_magic(duk_context *ctx, duk_idx_t index);
    void duk_get_memory_functions(duk_context *ctx, duk_memory_functions *out_funcs);
    duk_double_t duk_get_number(duk_context *ctx, duk_idx_t index);
    void *duk_get_pointer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_get_prop(duk_context *ctx, duk_idx_t obj_index);
    duk_bool_t duk_get_prop_index(duk_context *ctx, duk_idx_t obj_index, duk_uarridx_t arr_index);
    duk_bool_t duk_get_prop_string(duk_context *ctx, duk_idx_t obj_index, const char *key);
    void duk_get_prototype(duk_context *ctx, duk_idx_t index);
    const(char) *duk_get_string(duk_context *ctx, duk_idx_t index);
    duk_idx_t duk_get_top(duk_context *ctx);
    duk_idx_t duk_get_top_index(duk_context *ctx);
    duk_int_t duk_get_type(duk_context *ctx, duk_idx_t index);
    duk_uint_t duk_get_type_mask(duk_context *ctx, duk_idx_t index);
    duk_uint_t duk_get_uint(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_has_prop(duk_context *ctx, duk_idx_t obj_index);
    duk_bool_t duk_has_prop_index(duk_context *ctx, duk_idx_t obj_index, duk_uarridx_t arr_index);
    duk_bool_t duk_has_prop_string(duk_context *ctx, duk_idx_t obj_index, const char *key);
    void duk_hex_decode(duk_context *ctx, duk_idx_t index);
    const(char) *duk_hex_encode(duk_context *ctx, duk_idx_t index);
    void duk_insert(duk_context *ctx, duk_idx_t to_index);
    duk_bool_t duk_is_array(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_boolean(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_bound_function(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_buffer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_c_function(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_callable(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_constructor_call(duk_context *ctx);
    duk_bool_t duk_is_dynamic_buffer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_ecmascript_function(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_fixed_buffer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_function(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_lightfunc(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_nan(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_null(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_null_or_undefined(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_number(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_object(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_pointer(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_primitive(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_strict_call(duk_context *ctx);
    duk_bool_t duk_is_string(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_thread(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_undefined(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_is_valid_index(duk_context *ctx, duk_idx_t index);
    void duk_join(duk_context *ctx, duk_idx_t count);
    void duk_json_decode(duk_context *ctx, duk_idx_t index);
    const(char) *duk_json_encode(duk_context *ctx, duk_idx_t index);
    void duk_log(duk_context *ctx, duk_int_t level, const char *fmt, ...);
    void duk_log_va(duk_context *ctx, duk_int_t level, const char *fmt, va_list ap);
    void duk_map_string(duk_context *ctx, duk_idx_t index, duk_map_char_function callback, void *udata);
    void duk_new(duk_context *ctx, duk_idx_t nargs);
    duk_bool_t duk_next(duk_context *ctx, duk_idx_t enum_index, duk_bool_t get_value);
    duk_idx_t duk_normalize_index(duk_context *ctx, duk_idx_t index);
    duk_int_t duk_pcall(duk_context *ctx, duk_idx_t nargs);
    duk_int_t duk_pcall_method(duk_context *ctx, duk_idx_t nargs);
    duk_int_t duk_pcall_prop(duk_context *ctx, duk_idx_t obj_index, duk_idx_t nargs);
    void duk_pop(duk_context *ctx);
    void duk_pop_2(duk_context *ctx);
    void duk_pop_3(duk_context *ctx);
    void duk_pop_n(duk_context *ctx, duk_idx_t count);
    duk_idx_t duk_push_array(duk_context *ctx);
    void duk_push_boolean(duk_context *ctx, duk_bool_t val);
    void *duk_push_buffer_raw(duk_context *ctx, duk_size_t size, duk_bool_t dynamic);
    duk_idx_t duk_push_c_function(duk_context *ctx, duk_c_function func, duk_idx_t nargs);
    duk_idx_t duk_push_c_lightfunc(duk_context *ctx, duk_c_function func, duk_idx_t nargs, duk_idx_t length, duk_int_t magic);
    const(char) *duk_push_string_file_raw(duk_context *ctx, const char *path, duk_uint_t flags);
    duk_idx_t duk_push_thread_raw(duk_context *ctx, duk_uint_t flags);
    void duk_push_context_dump(duk_context *ctx);
    void duk_push_current_function(duk_context *ctx);
    void duk_push_current_thread(duk_context *ctx);
    duk_idx_t duk_push_error_object_raw(duk_context *ctx, duk_errcode_t err_code, const char *filename, duk_int_t line, const char *fmt, ...);
    duk_idx_t duk_push_error_object_va_raw(duk_context *ctx, duk_errcode_t err_code, const char *filename, duk_int_t line, const char *fmt, va_list ap);
    void duk_push_false(duk_context *ctx);
    void duk_push_global_object(duk_context *ctx);
    void duk_push_global_stash(duk_context *ctx);
    void duk_push_heap_stash(duk_context *ctx);
    duk_idx_t duk_push_heapptr(duk_context *ctx, void *ptr);
    void duk_push_int(duk_context *ctx, duk_int_t val);
    const(char) *duk_push_lstring(duk_context *ctx, const char *str, duk_size_t len);
    void duk_push_nan(duk_context *ctx);
    void duk_push_null(duk_context *ctx);
    void duk_push_number(duk_context *ctx, duk_double_t val);
    duk_idx_t duk_push_object(duk_context *ctx);
    void duk_push_pointer(duk_context *ctx, void *p);
    const(char) *duk_push_sprintf(duk_context *ctx, const char *fmt, ...);
    const(char) *duk_push_string(duk_context *ctx, const char *str);
    void duk_push_this(duk_context *ctx);
    void duk_push_thread_stash(duk_context *ctx, duk_context *target_ctx);
    void duk_push_true(duk_context *ctx);
    void duk_push_uint(duk_context *ctx, duk_uint_t val);
    void duk_push_undefined(duk_context *ctx);
    const(char) *duk_push_vsprintf(duk_context *ctx, const char *fmt, va_list ap);
    void duk_put_function_list(duk_context *ctx, duk_idx_t obj_index, const duk_function_list_entry *funcs);
    duk_bool_t duk_put_global_string(duk_context *ctx, const char *key);
    void duk_put_number_list(duk_context *ctx, duk_idx_t obj_index, const duk_number_list_entry *numbers);
    duk_bool_t duk_put_prop(duk_context *ctx, duk_idx_t obj_index);
    duk_bool_t duk_put_prop_index(duk_context *ctx, duk_idx_t obj_index, duk_uarridx_t arr_index);
    duk_bool_t duk_put_prop_string(duk_context *ctx, duk_idx_t obj_index, const char *key);
    void *duk_realloc(duk_context *ctx, void *ptr, duk_size_t size);
    void *duk_realloc_raw(duk_context *ctx, void *ptr, duk_size_t size);
    void duk_remove(duk_context *ctx, duk_idx_t index);
    void duk_replace(duk_context *ctx, duk_idx_t to_index);
    duk_bool_t duk_require_boolean(duk_context *ctx, duk_idx_t index);
    void *duk_require_buffer(duk_context *ctx, duk_idx_t index, duk_size_t *out_size);
    duk_c_function duk_require_c_function(duk_context *ctx, duk_idx_t index);
    duk_context *duk_require_context(duk_context *ctx, duk_idx_t index);
    void *duk_require_heapptr(duk_context *ctx, duk_idx_t index);
    duk_int_t duk_require_int(duk_context *ctx, duk_idx_t index);
    const(char) *duk_require_lstring(duk_context *ctx, duk_idx_t index, duk_size_t *out_len);
    duk_idx_t duk_require_normalize_index(duk_context *ctx, duk_idx_t index);
    void duk_require_null(duk_context *ctx, duk_idx_t index);
    duk_double_t duk_require_number(duk_context *ctx, duk_idx_t index);
    void *duk_require_pointer(duk_context *ctx, duk_idx_t index);
    void duk_require_stack(duk_context *ctx, duk_idx_t extra);
    void duk_require_stack_top(duk_context *ctx, duk_idx_t top);
    const(char) *duk_require_string(duk_context *ctx, duk_idx_t index);
    duk_idx_t duk_require_top_index(duk_context *ctx);
    duk_uint_t duk_require_uint(duk_context *ctx, duk_idx_t index);
    void duk_require_undefined(duk_context *ctx, duk_idx_t index);
    void duk_require_valid_index(duk_context *ctx, duk_idx_t index);
    void *duk_resize_buffer(duk_context *ctx, duk_idx_t index, duk_size_t new_size);
    duk_int_t duk_safe_call(duk_context *ctx, duk_safe_call_function func, duk_idx_t nargs, duk_idx_t nrets);
    const(char) *duk_safe_to_lstring(duk_context *ctx, duk_idx_t index, duk_size_t *out_len);
    void duk_set_finalizer(duk_context *ctx, duk_idx_t index);
    void duk_set_global_object(duk_context *ctx);
    void duk_set_magic(duk_context *ctx, duk_idx_t index, duk_int_t magic);
    void duk_set_prototype(duk_context *ctx, duk_idx_t index);
    void duk_set_top(duk_context *ctx, duk_idx_t index);
    duk_bool_t duk_strict_equals(duk_context *ctx, duk_idx_t index1, duk_idx_t index2);
    void duk_substring(duk_context *ctx, duk_idx_t index, duk_size_t start_char_offset, duk_size_t end_char_offset);
    void duk_swap(duk_context *ctx, duk_idx_t index1, duk_idx_t index2);
    void duk_swap_top(duk_context *ctx, duk_idx_t index);
    void duk_throw(duk_context *ctx);
    duk_bool_t duk_to_boolean(duk_context *ctx, duk_idx_t index);
    void *duk_to_buffer_raw(duk_context *ctx, duk_idx_t index, duk_size_t *out_size, duk_uint_t flags);
    void duk_to_defaultvalue(duk_context *ctx, duk_idx_t index, duk_int_t hint);
    duk_int_t duk_to_int(duk_context *ctx, duk_int_t index);
    duk_int32_t duk_to_int32(duk_context *ctx, duk_idx_t index);
    const(char) *duk_to_lstring(duk_context *ctx, duk_idx_t index, duk_size_t *out_len);
    void duk_to_null(duk_context *ctx, duk_idx_t index);
    duk_double_t duk_to_number(duk_context *ctx, duk_idx_t index);
    void duk_to_object(duk_context *ctx, duk_idx_t index);
    void *duk_to_pointer(duk_context *ctx, duk_idx_t index);
    void duk_to_primitive(duk_context *ctx, duk_idx_t index, duk_int_t hint);
    const(char) *duk_to_string(duk_context *ctx, duk_idx_t index);
    duk_uint_t duk_to_uint(duk_context *ctx, duk_idx_t index);
    duk_uint16_t duk_to_uint16(duk_context *ctx, duk_idx_t index);
    duk_uint32_t duk_to_uint32(duk_context *ctx, duk_idx_t index);
    void duk_to_undefined(duk_context *ctx, duk_idx_t index);
    void duk_trim(duk_context *ctx, duk_idx_t index);
    void duk_xcopymove_raw(duk_context *to_ctx, duk_context *from_ctx, duk_idx_t count, duk_bool_t is_copy);
}

module duktape;

public import duk_config;
/*
 *  Duktape public API for Duktape 2.3.0.
 *
 *  See the API reference for documentation on call semantics.  The exposed,
 *  supported API is between the "BEGIN PUBLIC API" and "END PUBLIC API"
 *  comments.  Other parts of the header are Duktape internal and related to
 *  e.g. platform/compiler/feature detection.
 *
 *  Git commit d7fdb67f18561a50e06bafd196c6b423af9ad6fe (v2.3.0).
 *  Git branch master.
 *
 *  See Duktape AUTHORS.rst and LICENSE.txt for copyright and
 *  licensing information.
 */

/* LICENSE.txt */
/*
 *  ===============
 *  Duktape license
 *  ===============
 *
 *  (http://opensource.org/licenses/MIT)
 *
 *  Copyright (c) 2013-2018 by Duktape authors (see AUTHORS.rst)
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

/* AUTHORS.rst */
/*
 *  ===============
 *  Duktape authors
 *  ===============
 *
 *  Copyright
 *  =========
 *
 *  Duktape copyrights are held by its authors.  Each author has a copyright
 *  to their contribution, and agrees to irrevocably license the contribution
 *  under the Duktape ``LICENSE.txt``.
 *
 *  Authors
 *  =======
 *
 *  Please include an e-mail address, a link to your GitHub profile, or something
 *  similar to allow your contribution to be identified accurately.
 *
 *  The following people have contributed code, website contents, or Wiki contents,
 *  and agreed to irrevocably license their contributions under the Duktape
 *  ``LICENSE.txt`` (in order of appearance):
 *
 *  * Sami Vaarala <sami.vaarala@iki.fi>
 *  * Niki Dobrev
 *  * Andreas \u00d6man <andreas@lonelycoder.com>
 *  * L\u00e1szl\u00f3 Lang\u00f3 <llango.u-szeged@partner.samsung.com>
 *  * Legimet <legimet.calc@gmail.com>
 *  * Karl Skomski <karl@skomski.com>
 *  * Bruce Pascoe <fatcerberus1@gmail.com>
 *  * Ren\u00e9 Hollander <rene@rene8888.at>
 *  * Julien Hamaide (https://github.com/crazyjul)
 *  * Sebastian G\u00f6tte (https://github.com/jaseg)
 *  * Tomasz Magulski (https://github.com/magul)
 *  * \D. Bohdan (https://github.com/dbohdan)
 *  * Ond\u0159ej Jirman (https://github.com/megous)
 *  * Sa\u00fal Ibarra Corretg\u00e9 <saghul@gmail.com>
 *  * Jeremy HU <huxingyi@msn.com>
 *  * Ole Andr\u00e9 Vadla Ravn\u00e5s (https://github.com/oleavr)
 *  * Harold Brenes (https://github.com/harold-b)
 *  * Oliver Crow (https://github.com/ocrow)
 *  * Jakub Ch\u0142api\u0144ski (https://github.com/jchlapinski)
 *  * Brett Vickers (https://github.com/beevik)
 *  * Dominik Okwieka (https://github.com/okitec)
 *  * Remko Tron\u00e7on (https://el-tramo.be)
 *  * Romero Malaquias (rbsm@ic.ufal.br)
 *  * Michael Drake <michael.drake@codethink.co.uk>
 *  * Steven Don (https://github.com/shdon)
 *  * Simon Stone (https://github.com/sstone1)
 *  * \J. McC. (https://github.com/jmhmccr)
 *  * Jakub Nowakowski (https://github.com/jimvonmoon)
 *  * Tommy Nguyen (https://github.com/tn0502)
 *  * Fabrice Fontaine (https://github.com/ffontaine)
 *  * Christopher Hiller (https://github.com/boneskull)
 *  * Gonzalo Diethelm (https://github.com/gonzus)
 *  * Michal Kasperek (https://github.com/michalkas)
 *  * Andrew Janke (https://github.com/apjanke)
 *  * Steve Fan (https://github.com/stevefan1999)
 *
 *  Other contributions
 *  ===================
 *
 *  The following people have contributed something other than code (e.g. reported
 *  bugs, provided ideas, etc; roughly in order of appearance):
 *
 *  * Greg Burns
 *  * Anthony Rabine
 *  * Carlos Costa
 *  * Aur\u00e9lien Bouilland
 *  * Preet Desai (Pris Matic)
 *  * judofyr (http://www.reddit.com/user/judofyr)
 *  * Jason Woofenden
 *  * Micha\u0142 Przyby\u015b
 *  * Anthony Howe
 *  * Conrad Pankoff
 *  * Jim Schimpf
 *  * Rajaran Gaunker (https://github.com/zimbabao)
 *  * Andreas \u00d6man
 *  * Doug Sanden
 *  * Josh Engebretson (https://github.com/JoshEngebretson)
 *  * Remo Eichenberger (https://github.com/remoe)
 *  * Mamod Mehyar (https://github.com/mamod)
 *  * David Demelier (https://github.com/markand)
 *  * Tim Caswell (https://github.com/creationix)
 *  * Mitchell Blank Jr (https://github.com/mitchblank)
 *  * https://github.com/yushli
 *  * Seo Sanghyeon (https://github.com/sanxiyn)
 *  * Han ChoongWoo (https://github.com/tunz)
 *  * Joshua Peek (https://github.com/josh)
 *  * Bruce E. Pascoe (https://github.com/fatcerberus)
 *  * https://github.com/Kelledin
 *  * https://github.com/sstruchtrup
 *  * Michael Drake (https://github.com/tlsa)
 *  * https://github.com/chris-y
 *  * Laurent Zubiaur (https://github.com/lzubiaur)
 *  * Neil Kolban (https://github.com/nkolban)
 *  * Wilhelm Wanecek (https://github.com/wanecek)
 *  * Andrew Janke (https://github.com/apjanke)
 *
 *  If you are accidentally missing from this list, send me an e-mail
 *  (``sami.vaarala@iki.fi``) and I'll fix the omission.
 */

import std.string : toStringz;

extern (C):

/*
 *  BEGIN PUBLimport core.stdc.config;
import core.stdc.stdio;

import core.sys.posix.sys.types;

IC API
 */

/*
 *  Version and Git commit identification
 */

/* Duktape version, (major * 10000) + (minor * 100) + patch.  Allows C code
 * to #if (DUK_VERSION >= NNN) against Duktape API version.  The same value
 * is also available to ECMAScript code in Duktape.version.  Unofficial
 * development snapshots have 99 for patch level (e.g. 0.10.99 would be a
 * development version after 0.10.0 but before the next official release).
 */
enum DUK_VERSION = 20300L;

/* Git commit, describe, and branch for Duktape build.  Useful for
 * non-official snapshot builds so that application code can easily log
 * which Duktape snapshot was used.  Not available in the ECMAScript
 * environment.
 */
enum DUK_GIT_COMMIT = "d7fdb67f18561a50e06bafd196c6b423af9ad6fe";
enum DUK_GIT_DESCRIBE = "v2.3.0";
enum DUK_GIT_BRANCH = "master";

/* External duk_config.h provides platform/compiler/OS dependent
 * typedefs and macros, and DUK_USE_xxx config options so that
 * the rest of Duktape doesn't need to do any feature detection.
 * DUK_VERSION is defined before including so that configuration
 * snippets can react to it.
 */

/*
 *  Avoid C++ name mangling
 */

/*
 *  Some defines forwarded from feature detection
 */

/*
 *  Public API specific typedefs
 *
 *  Many types are wrapped by Duktape for portability to rare platforms
 *  where e.g. 'int' is a 16-bit type.  See practical typing discussion
 *  in Duktape web documentation.
 */

/* duk_context is now defined in duk_config.h because it may also be
 * referenced there by prototypes.
 */

alias duk_c_function = int function (duk_context* ctx);
alias duk_alloc_function = void* function (void* udata, duk_size_t size);
alias duk_realloc_function = void* function (void* udata, void* ptr, duk_size_t size);
alias duk_free_function = void function (void* udata, void* ptr);
alias duk_fatal_function = void function (void* udata, const(char)* msg);
alias duk_decode_char_function = void function (void* udata, duk_codepoint_t codepoint);
alias duk_map_char_function = int function (void* udata, duk_codepoint_t codepoint);
alias duk_safe_call_function = int function (duk_context* ctx, void* udata);
alias duk_debug_read_function = ulong function (void* udata, char* buffer, duk_size_t length);
alias duk_debug_write_function = ulong function (void* udata, const(char)* buffer, duk_size_t length);
alias duk_debug_peek_function = ulong function (void* udata);
alias duk_debug_read_flush_function = void function (void* udata);
alias duk_debug_write_flush_function = void function (void* udata);
alias duk_debug_request_function = int function (duk_context* ctx, void* udata, duk_idx_t nvalues);
alias duk_debug_detached_function = void function (duk_context* ctx, void* udata);

struct duk_thread_state
{
    /* XXX: Enough space to hold internal suspend/resume structure.
    	 * This is rather awkward and to be fixed when the internal
    	 * structure is visible for the public API header.
    	 */
    char[128] data;
}

struct duk_memory_functions
{
    duk_alloc_function alloc_func;
    duk_realloc_function realloc_func;
    duk_free_function free_func;
    void* udata;
}

struct duk_function_list_entry
{
    const(char)* key;
    duk_c_function value;
    duk_idx_t nargs;
}

struct duk_number_list_entry
{
    const(char)* key;
    duk_double_t value;
}

struct duk_time_components
{
    duk_double_t year; /* year, e.g. 2016, ECMAScript year range */
    duk_double_t month; /* month: 1-12 */
    duk_double_t day; /* day: 1-31 */
    duk_double_t hours; /* hour: 0-59 */
    duk_double_t minutes; /* minute: 0-59 */
    duk_double_t seconds; /* second: 0-59 (in POSIX time no leap second) */
    duk_double_t milliseconds; /* may contain sub-millisecond fractions */
    duk_double_t weekday; /* weekday: 0-6, 0=Sunday, 1=Monday, ..., 6=Saturday */
}

/*
 *  Constants
 */

/* Duktape debug protocol version used by this build. */
enum DUK_DEBUG_PROTOCOL_VERSION = 2;

/* Used to represent invalid index; if caller uses this without checking,
 * this index will map to a non-existent stack entry.  Also used in some
 * API calls as a marker to denote "no value".
 */
enum DUK_INVALID_INDEX = DUK_IDX_MIN;

/* Indicates that a native function does not have a fixed number of args,
 * and the argument stack should not be capped/extended at all.
 */
enum DUK_VARARGS = cast(duk_int_t) -1;

/* Number of value stack entries (in addition to actual call arguments)
 * guaranteed to be allocated on entry to a Duktape/C function.
 */
enum DUK_API_ENTRY_STACK = 64U;

/* Value types, used by e.g. duk_get_type() */
enum DUK_TYPE_MIN = 0U;
enum DUK_TYPE_NONE = 0U; /* no value, e.g. invalid index */
enum DUK_TYPE_UNDEFINED = 1U; /* ECMAScript undefined */
enum DUK_TYPE_NULL = 2U; /* ECMAScript null */
enum DUK_TYPE_BOOLEAN = 3U; /* ECMAScript boolean: 0 or 1 */
enum DUK_TYPE_NUMBER = 4U; /* ECMAScript number: double */
enum DUK_TYPE_STRING = 5U; /* ECMAScript string: CESU-8 / extended UTF-8 encoded */
enum DUK_TYPE_OBJECT = 6U; /* ECMAScript object: includes objects, arrays, functions, threads */
enum DUK_TYPE_BUFFER = 7U; /* fixed or dynamic, garbage collected byte buffer */
enum DUK_TYPE_POINTER = 8U; /* raw void pointer */
enum DUK_TYPE_LIGHTFUNC = 9U; /* lightweight function pointer */
enum DUK_TYPE_MAX = 9U;

/* Value mask types, used by e.g. duk_get_type_mask() */
enum DUK_TYPE_MASK_NONE = 1U << DUK_TYPE_NONE;
enum DUK_TYPE_MASK_UNDEFINED = 1U << DUK_TYPE_UNDEFINED;
enum DUK_TYPE_MASK_NULL = 1U << DUK_TYPE_NULL;
enum DUK_TYPE_MASK_BOOLEAN = 1U << DUK_TYPE_BOOLEAN;
enum DUK_TYPE_MASK_NUMBER = 1U << DUK_TYPE_NUMBER;
enum DUK_TYPE_MASK_STRING = 1U << DUK_TYPE_STRING;
enum DUK_TYPE_MASK_OBJECT = 1U << DUK_TYPE_OBJECT;
enum DUK_TYPE_MASK_BUFFER = 1U << DUK_TYPE_BUFFER;
enum DUK_TYPE_MASK_POINTER = 1U << DUK_TYPE_POINTER;
enum DUK_TYPE_MASK_LIGHTFUNC = 1U << DUK_TYPE_LIGHTFUNC;
enum DUK_TYPE_MASK_THROW = 1U << 10; /* internal flag value: throw if mask doesn't match */
enum DUK_TYPE_MASK_PROMOTE = 1U << 11; /* internal flag value: promote to object if mask matches */

/* Coercion hints */
enum DUK_HINT_NONE = 0; /* prefer number, unless input is a Date, in which
 * case prefer string (E5 Section 8.12.8)
 */
enum DUK_HINT_STRING = 1; /* prefer string */
enum DUK_HINT_NUMBER = 2; /* prefer number */

/* Enumeration flags for duk_enum() */
enum DUK_ENUM_INCLUDE_NONENUMERABLE = 1U << 0; /* enumerate non-numerable properties in addition to enumerable */
enum DUK_ENUM_INCLUDE_HIDDEN = 1U << 1; /* enumerate hidden symbols too (in Duktape 1.x called internal properties) */
enum DUK_ENUM_INCLUDE_SYMBOLS = 1U << 2; /* enumerate symbols */
enum DUK_ENUM_EXCLUDE_STRINGS = 1U << 3; /* exclude strings */
enum DUK_ENUM_OWN_PROPERTIES_ONLY = 1U << 4; /* don't walk prototype chain, only check own properties */
enum DUK_ENUM_ARRAY_INDICES_ONLY = 1U << 5; /* only enumerate array indices */
/* XXX: misleading name */
enum DUK_ENUM_SORT_ARRAY_INDICES = 1U << 6; /* sort array indices (applied to full enumeration result, including inherited array indices); XXX: misleading name */
enum DUK_ENUM_NO_PROXY_BEHAVIOR = 1U << 7; /* enumerate a proxy object itself without invoking proxy behavior */

/* Compilation flags for duk_compile() and duk_eval() */
/* DUK_COMPILE_xxx bits 0-2 are reserved for an internal 'nargs' argument.
 */
enum DUK_COMPILE_EVAL = 1U << 3; /* compile eval code (instead of global code) */
enum DUK_COMPILE_FUNCTION = 1U << 4; /* compile function code (instead of global code) */
enum DUK_COMPILE_STRICT = 1U << 5; /* use strict (outer) context for global, eval, or function code */
enum DUK_COMPILE_SHEBANG = 1U << 6; /* allow shebang ('#! ...') comment on first line of source */
enum DUK_COMPILE_SAFE = 1U << 7; /* (internal) catch compilation errors */
enum DUK_COMPILE_NORESULT = 1U << 8; /* (internal) omit eval result */
enum DUK_COMPILE_NOSOURCE = 1U << 9; /* (internal) no source string on stack */
enum DUK_COMPILE_STRLEN = 1U << 10; /* (internal) take strlen() of src_buffer (avoids double evaluation in macro) */
enum DUK_COMPILE_NOFILENAME = 1U << 11; /* (internal) no filename on stack */
enum DUK_COMPILE_FUNCEXPR = 1U << 12; /* (internal) source is a function expression (used for Function constructor) */

/* Flags for duk_def_prop() and its variants; base flags + a lot of convenience shorthands */
enum DUK_DEFPROP_WRITABLE = 1U << 0; /* set writable (effective if DUK_DEFPROP_HAVE_WRITABLE set) */
enum DUK_DEFPROP_ENUMERABLE = 1U << 1; /* set enumerable (effective if DUK_DEFPROP_HAVE_ENUMERABLE set) */
enum DUK_DEFPROP_CONFIGURABLE = 1U << 2; /* set configurable (effective if DUK_DEFPROP_HAVE_CONFIGURABLE set) */
enum DUK_DEFPROP_HAVE_WRITABLE = 1U << 3; /* set/clear writable */
enum DUK_DEFPROP_HAVE_ENUMERABLE = 1U << 4; /* set/clear enumerable */
enum DUK_DEFPROP_HAVE_CONFIGURABLE = 1U << 5; /* set/clear configurable */
enum DUK_DEFPROP_HAVE_VALUE = 1U << 6; /* set value (given on value stack) */
enum DUK_DEFPROP_HAVE_GETTER = 1U << 7; /* set getter (given on value stack) */
enum DUK_DEFPROP_HAVE_SETTER = 1U << 8; /* set setter (given on value stack) */
enum DUK_DEFPROP_FORCE = 1U << 9; /* force change if possible, may still fail for e.g. virtual properties */
enum DUK_DEFPROP_SET_WRITABLE = DUK_DEFPROP_HAVE_WRITABLE | DUK_DEFPROP_WRITABLE;
enum DUK_DEFPROP_CLEAR_WRITABLE = DUK_DEFPROP_HAVE_WRITABLE;
enum DUK_DEFPROP_SET_ENUMERABLE = DUK_DEFPROP_HAVE_ENUMERABLE | DUK_DEFPROP_ENUMERABLE;
enum DUK_DEFPROP_CLEAR_ENUMERABLE = DUK_DEFPROP_HAVE_ENUMERABLE;
enum DUK_DEFPROP_SET_CONFIGURABLE = DUK_DEFPROP_HAVE_CONFIGURABLE | DUK_DEFPROP_CONFIGURABLE;
enum DUK_DEFPROP_CLEAR_CONFIGURABLE = DUK_DEFPROP_HAVE_CONFIGURABLE;
enum DUK_DEFPROP_W = DUK_DEFPROP_WRITABLE;
enum DUK_DEFPROP_E = DUK_DEFPROP_ENUMERABLE;
enum DUK_DEFPROP_C = DUK_DEFPROP_CONFIGURABLE;
enum DUK_DEFPROP_WE = DUK_DEFPROP_WRITABLE | DUK_DEFPROP_ENUMERABLE;
enum DUK_DEFPROP_WC = DUK_DEFPROP_WRITABLE | DUK_DEFPROP_CONFIGURABLE;
enum DUK_DEFPROP_WEC = DUK_DEFPROP_WRITABLE | DUK_DEFPROP_ENUMERABLE | DUK_DEFPROP_CONFIGURABLE;
enum DUK_DEFPROP_HAVE_W = DUK_DEFPROP_HAVE_WRITABLE;
enum DUK_DEFPROP_HAVE_E = DUK_DEFPROP_HAVE_ENUMERABLE;
enum DUK_DEFPROP_HAVE_C = DUK_DEFPROP_HAVE_CONFIGURABLE;
enum DUK_DEFPROP_HAVE_WE = DUK_DEFPROP_HAVE_WRITABLE | DUK_DEFPROP_HAVE_ENUMERABLE;
enum DUK_DEFPROP_HAVE_WC = DUK_DEFPROP_HAVE_WRITABLE | DUK_DEFPROP_HAVE_CONFIGURABLE;
enum DUK_DEFPROP_HAVE_WEC = DUK_DEFPROP_HAVE_WRITABLE | DUK_DEFPROP_HAVE_ENUMERABLE | DUK_DEFPROP_HAVE_CONFIGURABLE;
enum DUK_DEFPROP_SET_W = DUK_DEFPROP_SET_WRITABLE;
enum DUK_DEFPROP_SET_E = DUK_DEFPROP_SET_ENUMERABLE;
enum DUK_DEFPROP_SET_C = DUK_DEFPROP_SET_CONFIGURABLE;
enum DUK_DEFPROP_SET_WE = DUK_DEFPROP_SET_WRITABLE | DUK_DEFPROP_SET_ENUMERABLE;
enum DUK_DEFPROP_SET_WC = DUK_DEFPROP_SET_WRITABLE | DUK_DEFPROP_SET_CONFIGURABLE;
enum DUK_DEFPROP_SET_WEC = DUK_DEFPROP_SET_WRITABLE | DUK_DEFPROP_SET_ENUMERABLE | DUK_DEFPROP_SET_CONFIGURABLE;
enum DUK_DEFPROP_CLEAR_W = DUK_DEFPROP_CLEAR_WRITABLE;
enum DUK_DEFPROP_CLEAR_E = DUK_DEFPROP_CLEAR_ENUMERABLE;
enum DUK_DEFPROP_CLEAR_C = DUK_DEFPROP_CLEAR_CONFIGURABLE;
enum DUK_DEFPROP_CLEAR_WE = DUK_DEFPROP_CLEAR_WRITABLE | DUK_DEFPROP_CLEAR_ENUMERABLE;
enum DUK_DEFPROP_CLEAR_WC = DUK_DEFPROP_CLEAR_WRITABLE | DUK_DEFPROP_CLEAR_CONFIGURABLE;
enum DUK_DEFPROP_CLEAR_WEC = DUK_DEFPROP_CLEAR_WRITABLE | DUK_DEFPROP_CLEAR_ENUMERABLE | DUK_DEFPROP_CLEAR_CONFIGURABLE;
enum DUK_DEFPROP_ATTR_W = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_W;
enum DUK_DEFPROP_ATTR_E = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_E;
enum DUK_DEFPROP_ATTR_C = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_C;
enum DUK_DEFPROP_ATTR_WE = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_WE;
enum DUK_DEFPROP_ATTR_WC = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_WC;
enum DUK_DEFPROP_ATTR_WEC = DUK_DEFPROP_HAVE_WEC | DUK_DEFPROP_WEC;

/* Flags for duk_push_thread_raw() */
enum DUK_THREAD_NEW_GLOBAL_ENV = 1U << 0; /* create a new global environment */

/* Flags for duk_gc() */
enum DUK_GC_COMPACT = 1U << 0; /* compact heap objects */

/* Error codes (must be 8 bits at most, see duk_error.h) */
enum DUK_ERR_NONE = 0; /* no error (e.g. from duk_get_error_code()) */
enum DUK_ERR_ERROR = 1; /* Error */
enum DUK_ERR_EVAL_ERROR = 2; /* EvalError */
enum DUK_ERR_RANGE_ERROR = 3; /* RangeError */
enum DUK_ERR_REFERENCE_ERROR = 4; /* ReferenceError */
enum DUK_ERR_SYNTAX_ERROR = 5; /* SyntaxError */
enum DUK_ERR_TYPE_ERROR = 6; /* TypeError */
enum DUK_ERR_URI_ERROR = 7; /* URIError */

/* Return codes for C functions (shortcut for throwing an error) */
enum DUK_RET_ERROR = -DUK_ERR_ERROR;
enum DUK_RET_EVAL_ERROR = -DUK_ERR_EVAL_ERROR;
enum DUK_RET_RANGE_ERROR = -DUK_ERR_RANGE_ERROR;
enum DUK_RET_REFERENCE_ERROR = -DUK_ERR_REFERENCE_ERROR;
enum DUK_RET_SYNTAX_ERROR = -DUK_ERR_SYNTAX_ERROR;
enum DUK_RET_TYPE_ERROR = -DUK_ERR_TYPE_ERROR;
enum DUK_RET_URI_ERROR = -DUK_ERR_URI_ERROR;

/* Return codes for protected calls (duk_safe_call(), duk_pcall()) */
enum DUK_EXEC_SUCCESS = 0;
enum DUK_EXEC_ERROR = 1;

/* Debug levels for DUK_USE_DEBUG_WRITE(). */
enum DUK_LEVEL_DEBUG = 0;
enum DUK_LEVEL_DDEBUG = 1;
enum DUK_LEVEL_DDDEBUG = 2;

/*
 *  Macros to create Symbols as C statically constructed strings.
 *
 *  Call e.g. as DUK_HIDDEN_SYMBOL("myProperty") <=> ("\xFF" "myProperty").
 *  Local symbols have a unique suffix, caller should take care to avoid
 *  conflicting with the Duktape internal representation by e.g. prepending
 *  a '!' character: DUK_LOCAL_SYMBOL("myLocal", "!123").
 *
 *  Note that these can only be used for string constants, not dynamically
 *  created strings.
 */

/*
 *  If no variadic macros, __FILE__ and __LINE__ are passed through globals
 *  which is ugly and not thread safe.
 */

/*
 *  Context management
 */

duk_context* duk_create_heap (
    duk_alloc_function alloc_func,
    duk_realloc_function realloc_func,
    duk_free_function free_func,
    void* heap_udata,
    duk_fatal_function fatal_handler);
void duk_destroy_heap (duk_context* ctx);

void duk_suspend (duk_context* ctx, duk_thread_state* state);
void duk_resume (duk_context* ctx, const(duk_thread_state)* state);

extern (D) auto duk_create_heap_default()
{
    return duk_create_heap(null, null, null, null, null);
}

/*
 *  Memory management
 *
 *  Raw functions have no side effects (cannot trigger GC).
 */

void* duk_alloc_raw (duk_context* ctx, duk_size_t size);
void duk_free_raw (duk_context* ctx, void* ptr);
void* duk_realloc_raw (duk_context* ctx, void* ptr, duk_size_t size);
void* duk_alloc (duk_context* ctx, duk_size_t size);
void duk_free (duk_context* ctx, void* ptr);
void* duk_realloc (duk_context* ctx, void* ptr, duk_size_t size);
void duk_get_memory_functions (duk_context* ctx, duk_memory_functions* out_funcs);
void duk_gc (duk_context* ctx, duk_uint_t flags);

/*
 *  Error handling
 */

void duk_throw_raw (duk_context* ctx);
void duk_fatal_raw (duk_context* ctx, const(char)* err_msg);
void duk_error_raw (duk_context* ctx, duk_errcode_t err_code, const(char)* filename, duk_int_t line, const(char)* fmt, ...);

/* DUK_API_VARIADIC_MACROS */
/* For legacy compilers without variadic macros a macro hack is used to allow
 * variable arguments.  While the macro allows "return duk_error(...)", it
 * will fail with e.g. "(void) duk_error(...)".  The calls are noreturn but
 * with a return value to allow the "return duk_error(...)" idiom.  This may
 * cause some compiler warnings, but without noreturn the generated code is
 * often worse.  The same approach as with variadic macros (using
 * "(duk_error(...), 0)") won't work due to the macro hack structure.
 */

/* last value is func pointer, arguments follow in parens */

/* DUK_API_VARIADIC_MACROS */

void duk_error_va_raw (duk_context* ctx, duk_errcode_t err_code, const(char)* filename, duk_int_t line, const(char)* fmt, va_list ap);

duk_ret_t duk_throw(duk_context *ctx) {
    duk_throw_raw(ctx);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_fatal(duk_context *ctx, const(char) *err_msg) {
    duk_fatal_raw(ctx, err_msg);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_error(duk_context *ctx, duk_errcode_t err_code, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    //duk_error_raw(ctx, cast(duk_errcode_t)err_code, toStringz(__FILE__),
    //    cast(duk_int_t)__LINE__, fmt, ap);
    duk_error_va_raw(ctx, cast(duk_errcode_t)err_code, toStringz(__FILE__),
        cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t  duk_error_va(duk_context *ctx, duk_errcode_t err_code, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)err_code, toStringz(__FILE__),
        cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0; 
}

duk_ret_t duk_eval_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_EVAL_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_eval_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_EVAL_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}


duk_ret_t duk_generic_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_generic_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_range_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_RANGE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_range_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_RANGE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_reference_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_REFERENCE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_reference_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_REFERENCE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}


duk_ret_t duk_syntax_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_SYNTAX_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_syntax_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_SYNTAX_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_type_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_TYPE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_type_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_TYPE_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_uri_error(duk_context *ctx, const(char) *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);

    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_URI_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    va_end(ap);

    return cast(duk_ret_t)0;
}

duk_ret_t duk_uri_error_va(duk_context *ctx, const(char) *fmt, va_list ap) {
    duk_error_va_raw(ctx, cast(duk_errcode_t)DUK_ERR_URI_ERROR,
        toStringz(__FILE__), cast(duk_int_t)__LINE__, fmt, ap);

    return cast(duk_ret_t)0;
}

/*
 *  Other state related functions
 */

duk_bool_t duk_is_strict_call (duk_context* ctx);
duk_bool_t duk_is_constructor_call (duk_context* ctx);

/*
 *  Stack management
 */

duk_idx_t duk_normalize_index (duk_context* ctx, duk_idx_t idx);
duk_idx_t duk_require_normalize_index (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_valid_index (duk_context* ctx, duk_idx_t idx);
void duk_require_valid_index (duk_context* ctx, duk_idx_t idx);

duk_idx_t duk_get_top (duk_context* ctx);
void duk_set_top (duk_context* ctx, duk_idx_t idx);
duk_idx_t duk_get_top_index (duk_context* ctx);
duk_idx_t duk_require_top_index (duk_context* ctx);

/* Although extra/top could be an unsigned type here, using a signed type
 * makes the API more robust to calling code calculation errors or corner
 * cases (where caller might occasionally come up with negative values).
 * Negative values are treated as zero, which is better than casting them
 * to a large unsigned number.  (This principle is used elsewhere in the
 * API too.)
 */
duk_bool_t duk_check_stack (duk_context* ctx, duk_idx_t extra);
void duk_require_stack (duk_context* ctx, duk_idx_t extra);
duk_bool_t duk_check_stack_top (duk_context* ctx, duk_idx_t top);
void duk_require_stack_top (duk_context* ctx, duk_idx_t top);

/*
 *  Stack manipulation (other than push/pop)
 */

void duk_swap (duk_context* ctx, duk_idx_t idx1, duk_idx_t idx2);
void duk_swap_top (duk_context* ctx, duk_idx_t idx);
void duk_dup (duk_context* ctx, duk_idx_t from_idx);
void duk_dup_top (duk_context* ctx);
void duk_insert (duk_context* ctx, duk_idx_t to_idx);
void duk_replace (duk_context* ctx, duk_idx_t to_idx);
void duk_copy (duk_context* ctx, duk_idx_t from_idx, duk_idx_t to_idx);
void duk_remove (duk_context* ctx, duk_idx_t idx);
void duk_xcopymove_raw (duk_context* to_ctx, duk_context* from_ctx, duk_idx_t count, duk_bool_t is_copy);

/*is_copy*/

/*is_copy*/

/*
 *  Push operations
 *
 *  Push functions return the absolute (relative to bottom of frame)
 *  position of the pushed value for convenience.
 *
 *  Note: duk_dup() is technically a push.
 */

void duk_push_undefined (duk_context* ctx);
void duk_push_null (duk_context* ctx);
void duk_push_boolean (duk_context* ctx, duk_bool_t val);
void duk_push_true (duk_context* ctx);
void duk_push_false (duk_context* ctx);
void duk_push_number (duk_context* ctx, duk_double_t val);
void duk_push_nan (duk_context* ctx);
void duk_push_int (duk_context* ctx, duk_int_t val);
void duk_push_uint (duk_context* ctx, duk_uint_t val);
const(char)* duk_push_string (duk_context* ctx, const(char)* str);
const(char)* duk_push_lstring (duk_context* ctx, const(char)* str, duk_size_t len);
void duk_push_pointer (duk_context* ctx, void* p);
const(char)* duk_push_sprintf (duk_context* ctx, const(char)* fmt, ...);
const(char)* duk_push_vsprintf (duk_context* ctx, const(char)* fmt, va_list ap);

/* duk_push_literal() may evaluate its argument (a C string literal) more than
 * once on purpose.  When speed is preferred, sizeof() avoids an unnecessary
 * strlen() at runtime.  Sizeof("foo") == 4, so subtract 1.  The argument
 * must be non-NULL and should not contain internal NUL characters as the
 * behavior will then depend on config options.
 */

const(char)* duk_push_literal_raw (duk_context* ctx, const(char)* str, duk_size_t len);

extern (D) auto duk_push_literal(T0, T1)(auto ref T0 ctx, auto ref T1 cstring)
{
    return duk_push_literal_raw(ctx, cstring, (cstring).sizeof - 1U);
}

void duk_push_this (duk_context* ctx);
void duk_push_new_target (duk_context* ctx);
void duk_push_current_function (duk_context* ctx);
void duk_push_current_thread (duk_context* ctx);
void duk_push_global_object (duk_context* ctx);
void duk_push_heap_stash (duk_context* ctx);
void duk_push_global_stash (duk_context* ctx);
void duk_push_thread_stash (duk_context* ctx, duk_context* target_ctx);

duk_idx_t duk_push_object (duk_context* ctx);
duk_idx_t duk_push_bare_object (duk_context* ctx);
duk_idx_t duk_push_array (duk_context* ctx);
duk_idx_t duk_push_c_function (duk_context* ctx, duk_c_function func, duk_idx_t nargs);
duk_idx_t duk_push_c_lightfunc (duk_context* ctx, duk_c_function func, duk_idx_t nargs, duk_idx_t length, duk_int_t magic);
duk_idx_t duk_push_thread_raw (duk_context* ctx, duk_uint_t flags);
duk_idx_t duk_push_proxy (duk_context* ctx, duk_uint_t proxy_flags);

/*flags*/

/*flags*/

duk_idx_t duk_push_error_object_raw (duk_context* ctx, duk_errcode_t err_code, const(char)* filename, duk_int_t line, const(char)* fmt, ...);

/* Note: parentheses are required so that the comma expression works in assignments. */

/* last value is func pointer, arguments follow in parens */

duk_idx_t duk_push_error_object_va_raw (duk_context* ctx, duk_errcode_t err_code, const(char)* filename, duk_int_t line, const(char)* fmt, va_list ap);

extern (D) auto duk_push_error_object_va(T0, T1, T2, T3)(auto ref T0 ctx, auto ref T1 err_code, auto ref T2 fmt, auto ref T3 ap)
{
    return duk_push_error_object_va_raw(ctx, err_code, cast(const(char)*) DUK_FILE_MACRO, cast(duk_int_t) DUK_LINE_MACRO, fmt, ap);
}

enum DUK_BUF_FLAG_DYNAMIC = 1 << 0; /* internal flag: dynamic buffer */
enum DUK_BUF_FLAG_EXTERNAL = 1 << 1; /* internal flag: external buffer */
enum DUK_BUF_FLAG_NOZERO = 1 << 2; /* internal flag: don't zero allocated buffer */

void* duk_push_buffer_raw (duk_context* ctx, duk_size_t size, duk_small_uint_t flags);

void *duk_push_buffer(duk_context *ctx, duk_size_t size, duk_bool_t dynamic) {
    return duk_push_buffer_raw(ctx, size, dynamic ? DUK_BUF_FLAG_DYNAMIC : 0);
}

void *duk_push_fixed_buffer(duk_context *ctx, duk_size_t size) {
    return duk_push_buffer_raw(ctx, size, 0 /*flags*/);
}

void *duk_push_dynamic_buffer(duk_context *ctx, duk_size_t size) {
    return duk_push_buffer_raw(ctx, size, DUK_BUF_FLAG_DYNAMIC /*flags*/);
}

void duk_push_external_buffer(duk_context *ctx) {
    duk_push_buffer_raw(ctx, 0, DUK_BUF_FLAG_DYNAMIC | DUK_BUF_FLAG_EXTERNAL);
}

/*flags*/

/*flags*/

enum DUK_BUFOBJ_ARRAYBUFFER = 0;
enum DUK_BUFOBJ_NODEJS_BUFFER = 1;
enum DUK_BUFOBJ_DATAVIEW = 2;
enum DUK_BUFOBJ_INT8ARRAY = 3;
enum DUK_BUFOBJ_UINT8ARRAY = 4;
enum DUK_BUFOBJ_UINT8CLAMPEDARRAY = 5;
enum DUK_BUFOBJ_INT16ARRAY = 6;
enum DUK_BUFOBJ_UINT16ARRAY = 7;
enum DUK_BUFOBJ_INT32ARRAY = 8;
enum DUK_BUFOBJ_UINT32ARRAY = 9;
enum DUK_BUFOBJ_FLOAT32ARRAY = 10;
enum DUK_BUFOBJ_FLOAT64ARRAY = 11;

void duk_push_buffer_object (duk_context* ctx, duk_idx_t idx_buffer, duk_size_t byte_offset, duk_size_t byte_length, duk_uint_t flags);

duk_idx_t duk_push_heapptr (duk_context* ctx, void* ptr);

/*
 *  Pop operations
 */

void duk_pop (duk_context* ctx);
void duk_pop_n (duk_context* ctx, duk_idx_t count);
void duk_pop_2 (duk_context* ctx);
void duk_pop_3 (duk_context* ctx);

/*
 *  Type checks
 *
 *  duk_is_none(), which would indicate whether index it outside of stack,
 *  is not needed; duk_is_valid_index() gives the same information.
 */

duk_int_t duk_get_type (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_check_type (duk_context* ctx, duk_idx_t idx, duk_int_t type);
duk_uint_t duk_get_type_mask (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_check_type_mask (duk_context* ctx, duk_idx_t idx, duk_uint_t mask);

duk_bool_t duk_is_undefined (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_null (duk_context* ctx, duk_idx_t idx);

extern (D) int duk_is_null_or_undefined(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return (duk_get_type_mask(ctx, idx) & (DUK_TYPE_MASK_NULL | DUK_TYPE_MASK_UNDEFINED)) ? 1 : 0;
}

duk_bool_t duk_is_boolean (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_number (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_nan (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_string (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_object (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_buffer (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_buffer_data (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_pointer (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_lightfunc (duk_context* ctx, duk_idx_t idx);

duk_bool_t duk_is_symbol (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_array (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_function (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_c_function (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_ecmascript_function (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_bound_function (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_thread (duk_context* ctx, duk_idx_t idx);

alias duk_is_callable = duk_is_function;
duk_bool_t duk_is_constructable (duk_context* ctx, duk_idx_t idx);

duk_bool_t duk_is_dynamic_buffer (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_fixed_buffer (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_is_external_buffer (duk_context* ctx, duk_idx_t idx);

/* Buffers and lightfuncs are not considered primitive because they mimic
 * objects and e.g. duk_to_primitive() will coerce them instead of returning
 * them as is.  Symbols are represented as strings internally.
 */

/* Symbols are object coercible, covered by DUK_TYPE_MASK_STRING. */

duk_errcode_t duk_get_error_code (duk_context* ctx, duk_idx_t idx);

extern (D) auto duk_is_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) != 0;
}

extern (D) auto duk_is_eval_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_EVAL_ERROR;
}

extern (D) auto duk_is_range_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_RANGE_ERROR;
}

extern (D) auto duk_is_reference_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_REFERENCE_ERROR;
}

extern (D) auto duk_is_syntax_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_SYNTAX_ERROR;
}

extern (D) auto duk_is_type_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_TYPE_ERROR;
}

extern (D) auto duk_is_uri_error(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_get_error_code(ctx, idx) == DUK_ERR_URI_ERROR;
}

/*
 *  Get operations: no coercion, returns default value for invalid
 *  indices and invalid value types.
 *
 *  duk_get_undefined() and duk_get_null() would be pointless and
 *  are not included.
 */

duk_bool_t duk_get_boolean (duk_context* ctx, duk_idx_t idx);
duk_double_t duk_get_number (duk_context* ctx, duk_idx_t idx);
duk_int_t duk_get_int (duk_context* ctx, duk_idx_t idx);
duk_uint_t duk_get_uint (duk_context* ctx, duk_idx_t idx);
const(char)* duk_get_string (duk_context* ctx, duk_idx_t idx);
const(char)* duk_get_lstring (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len);
void* duk_get_buffer (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size);
void* duk_get_buffer_data (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size);
void* duk_get_pointer (duk_context* ctx, duk_idx_t idx);
duk_c_function duk_get_c_function (duk_context* ctx, duk_idx_t idx);
duk_context* duk_get_context (duk_context* ctx, duk_idx_t idx);
void* duk_get_heapptr (duk_context* ctx, duk_idx_t idx);

/*
 *  Get-with-explicit default operations: like get operations but with an
 *  explicit default value.
 */

duk_bool_t duk_get_boolean_default (duk_context* ctx, duk_idx_t idx, duk_bool_t def_value);
duk_double_t duk_get_number_default (duk_context* ctx, duk_idx_t idx, duk_double_t def_value);
duk_int_t duk_get_int_default (duk_context* ctx, duk_idx_t idx, duk_int_t def_value);
duk_uint_t duk_get_uint_default (duk_context* ctx, duk_idx_t idx, duk_uint_t def_value);
const(char)* duk_get_string_default (duk_context* ctx, duk_idx_t idx, const(char)* def_value);
const(char)* duk_get_lstring_default (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len, const(char)* def_ptr, duk_size_t def_len);
void* duk_get_buffer_default (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size, void* def_ptr, duk_size_t def_len);
void* duk_get_buffer_data_default (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size, void* def_ptr, duk_size_t def_len);
void* duk_get_pointer_default (duk_context* ctx, duk_idx_t idx, void* def_value);
duk_c_function duk_get_c_function_default (duk_context* ctx, duk_idx_t idx, duk_c_function def_value);
duk_context* duk_get_context_default (duk_context* ctx, duk_idx_t idx, duk_context* def_value);
void* duk_get_heapptr_default (duk_context* ctx, duk_idx_t idx, void* def_value);

/*
 *  Opt operations: like require operations but with an explicit default value
 *  when value is undefined or index is invalid, null and non-matching types
 *  cause a TypeError.
 */

duk_bool_t duk_opt_boolean (duk_context* ctx, duk_idx_t idx, duk_bool_t def_value);
duk_double_t duk_opt_number (duk_context* ctx, duk_idx_t idx, duk_double_t def_value);
duk_int_t duk_opt_int (duk_context* ctx, duk_idx_t idx, duk_int_t def_value);
duk_uint_t duk_opt_uint (duk_context* ctx, duk_idx_t idx, duk_uint_t def_value);
const(char)* duk_opt_string (duk_context* ctx, duk_idx_t idx, const(char)* def_ptr);
const(char)* duk_opt_lstring (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len, const(char)* def_ptr, duk_size_t def_len);
void* duk_opt_buffer (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size, void* def_ptr, duk_size_t def_size);
void* duk_opt_buffer_data (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size, void* def_ptr, duk_size_t def_size);
void* duk_opt_pointer (duk_context* ctx, duk_idx_t idx, void* def_value);
duk_c_function duk_opt_c_function (duk_context* ctx, duk_idx_t idx, duk_c_function def_value);
duk_context* duk_opt_context (duk_context* ctx, duk_idx_t idx, duk_context* def_value);
void* duk_opt_heapptr (duk_context* ctx, duk_idx_t idx, void* def_value);

/*
 *  Require operations: no coercion, throw error if index or type
 *  is incorrect.  No defaulting.
 */

void duk_require_type_mask(duk_context *ctx, duk_idx_t index, duk_uint_t mask) {
    duk_check_type_mask(ctx, index, mask | DUK_TYPE_MASK_THROW);
}

void duk_require_undefined (duk_context* ctx, duk_idx_t idx);
void duk_require_null (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_require_boolean (duk_context* ctx, duk_idx_t idx);
duk_double_t duk_require_number (duk_context* ctx, duk_idx_t idx);
duk_int_t duk_require_int (duk_context* ctx, duk_idx_t idx);
duk_uint_t duk_require_uint (duk_context* ctx, duk_idx_t idx);
const(char)* duk_require_string (duk_context* ctx, duk_idx_t idx);
const(char)* duk_require_lstring (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len);
void duk_require_object (duk_context* ctx, duk_idx_t idx);
void* duk_require_buffer (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size);
void* duk_require_buffer_data (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size);
void* duk_require_pointer (duk_context* ctx, duk_idx_t idx);
duk_c_function duk_require_c_function (duk_context* ctx, duk_idx_t idx);
duk_context* duk_require_context (duk_context* ctx, duk_idx_t idx);
void duk_require_function (duk_context* ctx, duk_idx_t idx);
alias duk_require_callable = duk_require_function;
void* duk_require_heapptr (duk_context* ctx, duk_idx_t idx);

/* Symbols are object coercible and covered by DUK_TYPE_MASK_STRING. */
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

void duk_to_undefined (duk_context* ctx, duk_idx_t idx);
void duk_to_null (duk_context* ctx, duk_idx_t idx);
duk_bool_t duk_to_boolean (duk_context* ctx, duk_idx_t idx);
duk_double_t duk_to_number (duk_context* ctx, duk_idx_t idx);
duk_int_t duk_to_int (duk_context* ctx, duk_idx_t idx);
duk_uint_t duk_to_uint (duk_context* ctx, duk_idx_t idx);
duk_int32_t duk_to_int32 (duk_context* ctx, duk_idx_t idx);
duk_uint32_t duk_to_uint32 (duk_context* ctx, duk_idx_t idx);
duk_uint16_t duk_to_uint16 (duk_context* ctx, duk_idx_t idx);
const(char)* duk_to_string (duk_context* ctx, duk_idx_t idx);
const(char)* duk_to_lstring (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len);
void* duk_to_buffer_raw (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size, duk_uint_t flags);
void* duk_to_pointer (duk_context* ctx, duk_idx_t idx);
void duk_to_object (duk_context* ctx, duk_idx_t idx);
void duk_to_primitive (duk_context* ctx, duk_idx_t idx, duk_int_t hint);

enum DUK_BUF_MODE_FIXED = 0; /* internal: request fixed buffer result */
enum DUK_BUF_MODE_DYNAMIC = 1; /* internal: request dynamic buffer result */
enum DUK_BUF_MODE_DONTCARE = 2; /* internal: don't care about fixed/dynamic nature */

extern (D) auto duk_to_buffer(T0, T1, T2)(auto ref T0 ctx, auto ref T1 idx, auto ref T2 out_size)
{
    return duk_to_buffer_raw(ctx, idx, out_size, DUK_BUF_MODE_DONTCARE);
}

extern (D) auto duk_to_fixed_buffer(T0, T1, T2)(auto ref T0 ctx, auto ref T1 idx, auto ref T2 out_size)
{
    return duk_to_buffer_raw(ctx, idx, out_size, DUK_BUF_MODE_FIXED);
}

extern (D) auto duk_to_dynamic_buffer(T0, T1, T2)(auto ref T0 ctx, auto ref T1 idx, auto ref T2 out_size)
{
    return duk_to_buffer_raw(ctx, idx, out_size, DUK_BUF_MODE_DYNAMIC);
}

/* safe variants of a few coercion operations */
const(char)* duk_safe_to_lstring (duk_context* ctx, duk_idx_t idx, duk_size_t* out_len);

extern (D) auto duk_safe_to_string(T0, T1)(auto ref T0 ctx, auto ref T1 idx)
{
    return duk_safe_to_lstring(ctx, idx, null);
}

/*
 *  Value length
 */

duk_size_t duk_get_length (duk_context* ctx, duk_idx_t idx);
void duk_set_length (duk_context* ctx, duk_idx_t idx, duk_size_t len);

/* duk_require_length()? */
/* duk_opt_length()? */

/*
 *  Misc conversion
 */

const(char)* duk_base64_encode (duk_context* ctx, duk_idx_t idx);
void duk_base64_decode (duk_context* ctx, duk_idx_t idx);
const(char)* duk_hex_encode (duk_context* ctx, duk_idx_t idx);
void duk_hex_decode (duk_context* ctx, duk_idx_t idx);
const(char)* duk_json_encode (duk_context* ctx, duk_idx_t idx);
void duk_json_decode (duk_context* ctx, duk_idx_t idx);

const(char)* duk_buffer_to_string (duk_context* ctx, duk_idx_t idx);

/*
 *  Buffer
 */

void* duk_resize_buffer (duk_context* ctx, duk_idx_t idx, duk_size_t new_size);
void* duk_steal_buffer (duk_context* ctx, duk_idx_t idx, duk_size_t* out_size);
void duk_config_buffer (duk_context* ctx, duk_idx_t idx, void* ptr, duk_size_t len);

/*
 *  Property access
 *
 *  The basic function assumes key is on stack.  The _(l)string variant takes
 *  a C string as a property name; the _literal variant takes a C literal.
 *  The _index variant takes an array index as a property name (e.g. 123 is
 *  equivalent to the key "123").  The _heapptr variant takes a raw, borrowed
 *  heap pointer.
 */

duk_bool_t duk_get_prop (duk_context* ctx, duk_idx_t obj_idx);
duk_bool_t duk_get_prop_string (duk_context* ctx, duk_idx_t obj_idx, const(char)* key);
duk_bool_t duk_get_prop_lstring (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_get_prop_literal_raw (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_get_prop_literal(T0, T1, T2)(auto ref T0 ctx, auto ref T1 obj_idx, auto ref T2 key)
{
    return duk_get_prop_literal_raw(ctx, obj_idx, key, (key).sizeof - 1U);
}

duk_bool_t duk_get_prop_index (duk_context* ctx, duk_idx_t obj_idx, duk_uarridx_t arr_idx);
duk_bool_t duk_get_prop_heapptr (duk_context* ctx, duk_idx_t obj_idx, void* ptr);
duk_bool_t duk_put_prop (duk_context* ctx, duk_idx_t obj_idx);
duk_bool_t duk_put_prop_string (duk_context* ctx, duk_idx_t obj_idx, const(char)* key);
duk_bool_t duk_put_prop_lstring (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_put_prop_literal_raw (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_put_prop_literal(T0, T1, T2)(auto ref T0 ctx, auto ref T1 obj_idx, auto ref T2 key)
{
    return duk_put_prop_literal_raw(ctx, obj_idx, key, (key).sizeof - 1U);
}

duk_bool_t duk_put_prop_index (duk_context* ctx, duk_idx_t obj_idx, duk_uarridx_t arr_idx);
duk_bool_t duk_put_prop_heapptr (duk_context* ctx, duk_idx_t obj_idx, void* ptr);
duk_bool_t duk_del_prop (duk_context* ctx, duk_idx_t obj_idx);
duk_bool_t duk_del_prop_string (duk_context* ctx, duk_idx_t obj_idx, const(char)* key);
duk_bool_t duk_del_prop_lstring (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_del_prop_literal_raw (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_del_prop_literal(T0, T1, T2)(auto ref T0 ctx, auto ref T1 obj_idx, auto ref T2 key)
{
    return duk_del_prop_literal_raw(ctx, obj_idx, key, (key).sizeof - 1U);
}

duk_bool_t duk_del_prop_index (duk_context* ctx, duk_idx_t obj_idx, duk_uarridx_t arr_idx);
duk_bool_t duk_del_prop_heapptr (duk_context* ctx, duk_idx_t obj_idx, void* ptr);
duk_bool_t duk_has_prop (duk_context* ctx, duk_idx_t obj_idx);
duk_bool_t duk_has_prop_string (duk_context* ctx, duk_idx_t obj_idx, const(char)* key);
duk_bool_t duk_has_prop_lstring (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_has_prop_literal_raw (duk_context* ctx, duk_idx_t obj_idx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_has_prop_literal(T0, T1, T2)(auto ref T0 ctx, auto ref T1 obj_idx, auto ref T2 key)
{
    return duk_has_prop_literal_raw(ctx, obj_idx, key, (key).sizeof - 1U);
}

duk_bool_t duk_has_prop_index (duk_context* ctx, duk_idx_t obj_idx, duk_uarridx_t arr_idx);
duk_bool_t duk_has_prop_heapptr (duk_context* ctx, duk_idx_t obj_idx, void* ptr);

void duk_get_prop_desc (duk_context* ctx, duk_idx_t obj_idx, duk_uint_t flags);
void duk_def_prop (duk_context* ctx, duk_idx_t obj_idx, duk_uint_t flags);

duk_bool_t duk_get_global_string (duk_context* ctx, const(char)* key);
duk_bool_t duk_get_global_lstring (duk_context* ctx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_get_global_literal_raw (duk_context* ctx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_get_global_literal(T0, T1)(auto ref T0 ctx, auto ref T1 key)
{
    return duk_get_global_literal_raw(ctx, key, (key).sizeof - 1U);
}

duk_bool_t duk_get_global_heapptr (duk_context* ctx, void* ptr);
duk_bool_t duk_put_global_string (duk_context* ctx, const(char)* key);
duk_bool_t duk_put_global_lstring (duk_context* ctx, const(char)* key, duk_size_t key_len);

duk_bool_t duk_put_global_literal_raw (duk_context* ctx, const(char)* key, duk_size_t key_len);

extern (D) auto duk_put_global_literal(T0, T1)(auto ref T0 ctx, auto ref T1 key)
{
    return duk_put_global_literal_raw(ctx, key, (key).sizeof - 1U);
}

duk_bool_t duk_put_global_heapptr (duk_context* ctx, void* ptr);

/*
 *  Inspection
 */

void duk_inspect_value (duk_context* ctx, duk_idx_t idx);
void duk_inspect_callstack_entry (duk_context* ctx, duk_int_t level);

/*
 *  Object prototype
 */

void duk_get_prototype (duk_context* ctx, duk_idx_t idx);
void duk_set_prototype (duk_context* ctx, duk_idx_t idx);

/*
 *  Object finalizer
 */

void duk_get_finalizer (duk_context* ctx, duk_idx_t idx);
void duk_set_finalizer (duk_context* ctx, duk_idx_t idx);

/*
 *  Global object
 */

void duk_set_global_object (duk_context* ctx);

/*
 *  Duktape/C function magic value
 */

duk_int_t duk_get_magic (duk_context* ctx, duk_idx_t idx);
void duk_set_magic (duk_context* ctx, duk_idx_t idx, duk_int_t magic);
duk_int_t duk_get_current_magic (duk_context* ctx);

/*
 *  Module helpers: put multiple function or constant properties
 */

void duk_put_function_list (duk_context* ctx, duk_idx_t obj_idx, const(duk_function_list_entry)* funcs);
void duk_put_number_list (duk_context* ctx, duk_idx_t obj_idx, const(duk_number_list_entry)* numbers);

/*
 *  Object operations
 */

void duk_compact (duk_context* ctx, duk_idx_t obj_idx);
void duk_enum (duk_context* ctx, duk_idx_t obj_idx, duk_uint_t enum_flags);
duk_bool_t duk_next (duk_context* ctx, duk_idx_t enum_idx, duk_bool_t get_value);
void duk_seal (duk_context* ctx, duk_idx_t obj_idx);
void duk_freeze (duk_context* ctx, duk_idx_t obj_idx);

/*
 *  String manipulation
 */

void duk_concat (duk_context* ctx, duk_idx_t count);
void duk_join (duk_context* ctx, duk_idx_t count);
void duk_decode_string (duk_context* ctx, duk_idx_t idx, duk_decode_char_function callback, void* udata);
void duk_map_string (duk_context* ctx, duk_idx_t idx, duk_map_char_function callback, void* udata);
void duk_substring (duk_context* ctx, duk_idx_t idx, duk_size_t start_char_offset, duk_size_t end_char_offset);
void duk_trim (duk_context* ctx, duk_idx_t idx);
duk_codepoint_t duk_char_code_at (duk_context* ctx, duk_idx_t idx, duk_size_t char_offset);

/*
 *  ECMAScript operators
 */

duk_bool_t duk_equals (duk_context* ctx, duk_idx_t idx1, duk_idx_t idx2);
duk_bool_t duk_strict_equals (duk_context* ctx, duk_idx_t idx1, duk_idx_t idx2);
duk_bool_t duk_samevalue (duk_context* ctx, duk_idx_t idx1, duk_idx_t idx2);
duk_bool_t duk_instanceof (duk_context* ctx, duk_idx_t idx1, duk_idx_t idx2);

/*
 *  Random
 */

duk_double_t duk_random (duk_context* ctx);

/*
 *  Function (method) calls
 */

void duk_call (duk_context* ctx, duk_idx_t nargs);
void duk_call_method (duk_context* ctx, duk_idx_t nargs);
void duk_call_prop (duk_context* ctx, duk_idx_t obj_idx, duk_idx_t nargs);
duk_int_t duk_pcall (duk_context* ctx, duk_idx_t nargs);
duk_int_t duk_pcall_method (duk_context* ctx, duk_idx_t nargs);
duk_int_t duk_pcall_prop (duk_context* ctx, duk_idx_t obj_idx, duk_idx_t nargs);
void duk_new (duk_context* ctx, duk_idx_t nargs);
duk_int_t duk_pnew (duk_context* ctx, duk_idx_t nargs);
duk_int_t duk_safe_call (duk_context* ctx, duk_safe_call_function func, void* udata, duk_idx_t nargs, duk_idx_t nrets);

/*
 *  Thread management
 */

/* There are currently no native functions to yield/resume, due to the internal
 * limitations on coroutine handling.  These will be added later.
 */

/*
 *  Compilation and evaluation
 */

duk_int_t duk_eval_raw (duk_context* ctx, const(char)* src_buffer, duk_size_t src_length, duk_uint_t flags);
duk_int_t duk_compile_raw (duk_context* ctx, const(char)* src_buffer, duk_size_t src_length, duk_uint_t flags);

/* plain */
void duk_eval(duk_context *ctx) {
    duk_eval_raw(ctx, null, 0, 1 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOFILENAME);
}

void duk_eval_noresult(duk_context *ctx) {
    duk_eval_raw(ctx, null, 0, 1 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval(duk_context *ctx) {
    return duk_eval_raw(ctx, null, 0, 1 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval_noresult(duk_context *ctx) {
    return duk_eval_raw(ctx, null, 0, 1 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

void duk_compile(duk_context *ctx, duk_uint_t flags) {
    duk_compile_raw(ctx, null, 0, 2 /*args*/ | flags);
}

duk_int_t duk_pcompile(duk_context *ctx, duk_uint_t flags) {
    return duk_compile_raw(ctx, null, 0, 2 /*args*/ | flags | DUK_COMPILE_SAFE);
}

/* string */
void duk_eval_string(duk_context *ctx, const char *src) {
    duk_eval_raw(ctx, src, 0, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NOFILENAME);
}

void duk_eval_string_noresult(duk_context *ctx, const char *src) {
    duk_eval_raw(ctx, src, 0, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval_string(duk_context *ctx, const char *src) {
    return duk_eval_raw(ctx, src, 0, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval_string_noresult(duk_context *ctx, const char *src) {
    return duk_eval_raw(ctx, src, 0, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

void duk_compile_string(duk_context *ctx, duk_uint_t flags, const char *src) {
    duk_compile_raw(ctx, src, 0, 0 /*args*/ | flags | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NOFILENAME);
}

void duk_compile_string_filename(duk_context *ctx, duk_uint_t flags, const char *src) {
    duk_compile_raw(ctx, src, 0, 1 /*args*/ | flags | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

duk_int_t duk_pcompile_string(duk_context *ctx, duk_uint_t flags, const char *src) {
    return duk_compile_raw(ctx, src, 0, 0 /*args*/ | flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_pcompile_string_filename(duk_context *ctx, duk_uint_t flags, const char *src) {
    return duk_compile_raw(ctx, src, 0, 1 /*args*/ | flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_STRLEN);
}

/* lstring */
void duk_eval_lstring(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_eval_raw(ctx, buf, len, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NOFILENAME);
}

void duk_eval_lstring_noresult(duk_context *ctx, const char *buf, duk_size_t len)  {
    duk_eval_raw(ctx, buf, len, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval_lstring(duk_context *ctx, const char *buf, duk_size_t len)  {
    return duk_eval_raw(ctx, buf, len, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_NOSOURCE | DUK_COMPILE_SAFE | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_peval_lstring_noresult(duk_context *ctx, const char *buf, duk_size_t len)  {
    return duk_eval_raw(ctx, buf, len, 0 /*args*/ | DUK_COMPILE_EVAL | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NORESULT | DUK_COMPILE_NOFILENAME);
}

void duk_compile_lstring(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    duk_compile_raw(ctx, buf, len, 0 /*args*/ | flags | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NOFILENAME);
}

void duk_compile_lstring_filename(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    duk_compile_raw(ctx, buf, len, 1 /*args*/ | flags | DUK_COMPILE_NOSOURCE);
}

duk_int_t duk_pcompile_lstring(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    return duk_compile_raw(ctx, buf, len, 0 /*args*/ | flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE | DUK_COMPILE_NOFILENAME);
}

duk_int_t duk_pcompile_lstring_filename(duk_context *ctx, duk_uint_t flags, const char *buf, duk_size_t len)  {
    return duk_compile_raw(ctx, buf, len, 1 /*args*/ | flags | DUK_COMPILE_SAFE | DUK_COMPILE_NOSOURCE);
}


/*
 *  Bytecode load/dump
 */

void duk_dump_function (duk_context* ctx);
void duk_load_function (duk_context* ctx);

/*
 *  Debugging
 */

void duk_push_context_dump (duk_context* ctx);

/*
 *  Debugger (debug protocol)
 */

void duk_debugger_attach (
    duk_context* ctx,
    duk_debug_read_function read_cb,
    duk_debug_write_function write_cb,
    duk_debug_peek_function peek_cb,
    duk_debug_read_flush_function read_flush_cb,
    duk_debug_write_flush_function write_flush_cb,
    duk_debug_request_function request_cb,
    duk_debug_detached_function detached_cb,
    void* udata);
void duk_debugger_detach (duk_context* ctx);
void duk_debugger_cooperate (duk_context* ctx);
duk_bool_t duk_debugger_notify (duk_context* ctx, duk_idx_t nvalues);
void duk_debugger_pause (duk_context* ctx);

/*
 *  Time handling
 */

duk_double_t duk_get_now (duk_context* ctx);
void duk_time_to_components (duk_context* ctx, duk_double_t timeval, duk_time_components* comp);
duk_double_t duk_components_to_time (duk_context* ctx, duk_time_components* comp);

/*
 *  Date provider related constants
 *
 *  NOTE: These are "semi public" - you should only use these if you write
 *  your own platform specific Date provider, see doc/datetime.rst.
 */

/* Millisecond count constants. */
enum DUK_DATE_MSEC_SECOND = 1000L;
enum DUK_DATE_MSEC_MINUTE = 60L * 1000L;
enum DUK_DATE_MSEC_HOUR = 60L * 60L * 1000L;
enum DUK_DATE_MSEC_DAY = 24L * 60L * 60L * 1000L;

/* ECMAScript date range is 100 million days from Epoch:
 * > 100e6 * 24 * 60 * 60 * 1000  // 100M days in millisecs
 * 8640000000000000
 * (= 8.64e15)
 */
enum DUK_DATE_MSEC_100M_DAYS = 8.64e15;
enum DUK_DATE_MSEC_100M_DAYS_LEEWAY = 8.64e15 + 24 * 3600e3;

/* ECMAScript year range:
 * > new Date(100e6 * 24 * 3600e3).toISOString()
 * '+275760-09-13T00:00:00.000Z'
 * > new Date(-100e6 * 24 * 3600e3).toISOString()
 * '-271821-04-20T00:00:00.000Z'
 */
enum DUK_DATE_MIN_ECMA_YEAR = -271821L;
enum DUK_DATE_MAX_ECMA_YEAR = 275760L;

/* Part indices for internal breakdowns.  Part order from DUK_DATE_IDX_YEAR
 * to DUK_DATE_IDX_MILLISECOND matches argument ordering of ECMAScript API
 * calls (like Date constructor call).  Some functions in duk_bi_date.c
 * depend on the specific ordering, so change with care.  16 bits are not
 * enough for all parts (year, specifically).
 *
 * Must be in-sync with genbuiltins.py.
 */
enum DUK_DATE_IDX_YEAR = 0; /* year */
enum DUK_DATE_IDX_MONTH = 1; /* month: 0 to 11 */
enum DUK_DATE_IDX_DAY = 2; /* day within month: 0 to 30 */
enum DUK_DATE_IDX_HOUR = 3;
enum DUK_DATE_IDX_MINUTE = 4;
enum DUK_DATE_IDX_SECOND = 5;
enum DUK_DATE_IDX_MILLISECOND = 6;
enum DUK_DATE_IDX_WEEKDAY = 7; /* weekday: 0 to 6, 0=sunday, 1=monday, etc */
enum DUK_DATE_IDX_NUM_PARTS = 8;

/* Internal API call flags, used for various functions in duk_bi_date.c.
 * Certain flags are used by only certain functions, but since the flags
 * don't overlap, a single flags value can be passed around to multiple
 * functions.
 *
 * The unused top bits of the flags field are also used to pass values
 * to helpers (duk__get_part_helper() and duk__set_part_helper()).
 *
 * Must be in-sync with genbuiltins.py.
 */

/* NOTE: when writing a Date provider you only need a few specific
 * flags from here, the rest are internal.  Avoid using anything you
 * don't need.
 */

enum DUK_DATE_FLAG_NAN_TO_ZERO = 1 << 0; /* timeval breakdown: internal time value NaN -> zero */
enum DUK_DATE_FLAG_NAN_TO_RANGE_ERROR = 1 << 1; /* timeval breakdown: internal time value NaN -> RangeError (toISOString) */
enum DUK_DATE_FLAG_ONEBASED = 1 << 2; /* timeval breakdown: convert month and day-of-month parts to one-based (default is zero-based) */
enum DUK_DATE_FLAG_EQUIVYEAR = 1 << 3; /* timeval breakdown: replace year with equivalent year in the [1971,2037] range for DST calculations */
enum DUK_DATE_FLAG_LOCALTIME = 1 << 4; /* convert time value to local time */
enum DUK_DATE_FLAG_SUB1900 = 1 << 5; /* getter: subtract 1900 from year when getting year part */
enum DUK_DATE_FLAG_TOSTRING_DATE = 1 << 6; /* include date part in string conversion result */
enum DUK_DATE_FLAG_TOSTRING_TIME = 1 << 7; /* include time part in string conversion result */
enum DUK_DATE_FLAG_TOSTRING_LOCALE = 1 << 8; /* use locale specific formatting if available */
enum DUK_DATE_FLAG_TIMESETTER = 1 << 9; /* setter: call is a time setter (affects hour, min, sec, ms); otherwise date setter (affects year, month, day-in-month) */
enum DUK_DATE_FLAG_YEAR_FIXUP = 1 << 10; /* setter: perform 2-digit year fixup (00...99 -> 1900...1999) */
enum DUK_DATE_FLAG_SEP_T = 1 << 11; /* string conversion: use 'T' instead of ' ' as a separator */
enum DUK_DATE_FLAG_VALUE_SHIFT = 12; /* additional values begin at bit 12 */

/*
 *  ROM pointer compression
 */

/* Support array for ROM pointer compression.  Only declared when ROM
 * pointer compression is active.
 */

/*
 *  C++ name mangling
 */

/* end 'extern "C"' wrapper */

/*
 *  END PUBLIC API
 */

/* DUKTAPE_H_INCLUDED */

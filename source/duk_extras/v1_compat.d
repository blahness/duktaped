module duk_extras.v1_compat;

import core.stdc.stdio;
import core.stdc.string;
import std.conv;
import std.exception;
import std.file;

import duktape;

enum DUK_STRING_PUSH_SAFE =              (1 << 0);    /* no error if file does not exist */

/*
 *  Push operations
 */
 
const(char) *duk_push_string_file_raw(duk_context *ctx, const(char) *path, duk_uint_t flags) {
    if (path != null && strlen(path) > 0) {
        char[] content = cast(char[])read(path.to!string).ifThrown(null);

        if (content.length > 0) {
            auto buf = cast(char *)duk_push_fixed_buffer(ctx,
                cast(duk_size_t)content.length);

            memcpy(buf, content.ptr, content.length);

            return duk_buffer_to_string(ctx, -1);
        }
    }

    if (flags & DUK_STRING_PUSH_SAFE) {
        duk_push_undefined(ctx);
    } else {
        duk_error(ctx, DUK_ERR_TYPE_ERROR, "read file error");
    }

    return null;
}

const(char) *duk_push_string_file(duk_context *ctx, const(char) *path) {
    return duk_push_string_file_raw(ctx, path, 0);
}

/* file */
void duk_eval_file(duk_context *ctx, const(char) *path) {
    duk_push_string_file_raw(ctx, path, 0);
    duk_push_string(ctx, path);
    duk_compile(ctx, DUK_COMPILE_EVAL);
    duk_push_global_object(ctx);  /* 'this' binding */
    duk_call_method(ctx, 0);}

void duk_eval_file_noresult(duk_context *ctx, const(char) *path) {
    duk_eval_file(ctx, path);
    duk_pop(ctx);
}

duk_int_t duk_peval_file(duk_context *ctx, const(char) *path) {
    duk_int_t rc;

    duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
    duk_push_string(ctx, path);
    rc = duk_pcompile(ctx, DUK_COMPILE_EVAL);
    if (rc != 0) {
        return rc;
    }
    duk_push_global_object(ctx);  /* 'this' binding */
    rc = duk_pcall_method(ctx, 0);
    return rc;
}

duk_int_t duk_peval_file_noresult(duk_context *ctx, const(char) *path) {
    duk_int_t rc;

    rc = duk_peval_file(ctx, path);
    duk_pop(ctx);
    return rc;
}

void duk_compile_file(duk_context *ctx, duk_uint_t flags, const(char) *path) {
    duk_push_string_file_raw(ctx, path, 0);
    duk_push_string(ctx, path);
    duk_compile(ctx, flags);
}

duk_int_t duk_pcompile_file(duk_context *ctx, duk_uint_t flags, const(char) *path) {
    duk_int_t rc;

    duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
    duk_push_string(ctx, path);
    rc = duk_pcompile(ctx, flags);
    return rc;
}

/*
 *  duk_dump_context_{stdout,stderr}()
 */

void duk_dump_context_stdout(duk_context *ctx) {
    duk_push_context_dump(ctx);
    fprintf(stdout, "%s\n", duk_safe_to_string(ctx, -1));
    duk_pop(ctx);
}

void duk_dump_context_stderr(duk_context *ctx) {
    duk_push_context_dump(ctx);
    fprintf(stderr, "%s\n", duk_safe_to_string(ctx, -1));
    duk_pop(ctx);
}

/*
 *  duk_to_defaultvalue()
 */

void duk_to_defaultvalue(duk_context *ctx, duk_idx_t idx, duk_int_t hint) {
    duk_require_type_mask(ctx, idx, DUK_TYPE_MASK_OBJECT |
                                    DUK_TYPE_MASK_BUFFER |
                                    DUK_TYPE_MASK_LIGHTFUNC);
    duk_to_primitive(ctx, idx, hint);
}

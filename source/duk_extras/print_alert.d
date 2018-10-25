module duk_extras.print_alert;

/*
 *  Duktape 1.x compatible print() and alert() bindings.
 */

import core.stdc.stdio;
import core.stdc.string;

import duktape;

enum DUK_PRINT_ALERT_FLUSH = true;  /* Flush after stdout/stderr write (Duktape 1.x: yes) */
enum DUK_PRINT_ALERT_SMALL = false; /* Prefer smaller footprint (but slower and more memory churn) */

private duk_ret_t duk__print_alert_helper_small(duk_context *ctx, FILE *fh) {
    duk_idx_t nargs;
    const(duk_uint8_t) *buf;
    duk_size_t sz_buf;

    nargs = duk_get_top(ctx);

    /* If argument count is 1 and first argument is a buffer, write the buffer
    * as raw data into the file without a newline; this allows exact control
    * over stdout/stderr without an additional entrypoint (useful for now).
    * Otherwise current print/alert semantics are to ToString() coerce
    * arguments, join them with a single space, and append a newline.
    */

    if (nargs == 1 && duk_is_buffer(ctx, 0)) {
        buf = cast(const(duk_uint8_t) *) duk_get_buffer(ctx, 0, &sz_buf);
        fwrite(cast(const void *) buf, 1, cast(size_t) sz_buf, fh);
    } else {
        duk_push_string(ctx, " ");
        duk_insert(ctx, 0);
        duk_concat(ctx, nargs);
        fprintf(fh, "%s\n", duk_require_string(ctx, -1));
    }

    static if (DUK_PRINT_ALERT_FLUSH) {
        fflush(fh);
    }

    return 0;
}

/* Faster, less churn, higher footprint option. */
private duk_ret_t duk__print_alert_helper(duk_context *ctx, FILE *fh) {
    duk_idx_t nargs;
    const(duk_uint8_t) *buf;
    duk_size_t sz_buf;
    const char nl = cast(const char) '\n';
    duk_uint8_t[256] buf_stack;

    nargs = duk_get_top(ctx);

    /* If argument count is 1 and first argument is a buffer, write the buffer
    * as raw data into the file without a newline; this allows exact control
    * over stdout/stderr without an additional entrypoint (useful for now).
    * Otherwise current print/alert semantics are to ToString() coerce
    * arguments, join them with a single space, and append a newline.
    */

    if (nargs == 1 && duk_is_buffer(ctx, 0)) {
        buf = cast(const(duk_uint8_t) *) duk_get_buffer(ctx, 0, &sz_buf);
    } else if (nargs > 0) {
        duk_idx_t i;
        duk_size_t sz_str;
        const(duk_uint8_t) *p_str;
        duk_uint8_t *p;

        sz_buf = cast(duk_size_t) nargs;  /* spaces (nargs - 1) + newline */
        for (i = 0; i < nargs; i++) {
            duk_to_lstring(ctx, i, &sz_str);
            sz_buf += sz_str;
        }

        if (sz_buf <= buf_stack.sizeof) {
            p = cast(duk_uint8_t *) buf_stack;
        } else {
            p = cast(duk_uint8_t *) duk_push_fixed_buffer(ctx, sz_buf);
        }

        buf = cast(const(duk_uint8_t) *) p;
        for (i = 0; i < nargs; i++) {
            p_str = cast(const(duk_uint8_t) *) duk_get_lstring(ctx, i, &sz_str);
            memcpy(cast(void *) p, cast(const void *) p_str, sz_str);
            p += sz_str;
            *p++ = cast(duk_uint8_t) (i == nargs - 1 ? '\n' : ' ');
        }
    } else {
        buf = cast(const(duk_uint8_t) *) &nl;
        sz_buf = 1;
    }

    /* 'buf' contains the string to write, 'sz_buf' contains the length
    * (which may be zero).
    */

    if (sz_buf > 0) {
        fwrite(cast(const void *) buf, 1, cast(size_t) sz_buf, fh);
        static if (DUK_PRINT_ALERT_FLUSH) {
            fflush(fh);
        }
    }

    return 0;
}

extern(C) private duk_ret_t duk__print(duk_context *ctx) {
    if (DUK_PRINT_ALERT_SMALL)
        return duk__print_alert_helper_small(ctx, stdout);
    else
	    return duk__print_alert_helper(ctx, stdout);
}

extern(C) private duk_ret_t duk__alert(duk_context *ctx) {
    if (DUK_PRINT_ALERT_SMALL)
	    return duk__print_alert_helper_small(ctx, stderr);
    else
        return duk__print_alert_helper(ctx, stderr);
}

void duk_print_alert_init(duk_context *ctx, duk_uint_t flags) {
	//(void) flags;  /* unused at the moment */

	/* XXX: use duk_def_prop_list(). */
	duk_push_global_object(ctx);
	duk_push_string(ctx, "print");
	duk_push_c_function(ctx, &duk__print, DUK_VARARGS);
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE | DUK_DEFPROP_SET_WRITABLE | DUK_DEFPROP_SET_CONFIGURABLE);
	duk_push_string(ctx, "alert");
	duk_push_c_function(ctx, &duk__alert, DUK_VARARGS);
	duk_def_prop(ctx, -3, DUK_DEFPROP_HAVE_VALUE | DUK_DEFPROP_SET_WRITABLE | DUK_DEFPROP_SET_CONFIGURABLE);
	duk_pop(ctx);
}

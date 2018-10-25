import std.conv;
import std.stdio;
import std.string;

import duktape;

extern (C) int dummy_upper_case(duk_context *ctx) {
    duk_size_t sz;
    const char *val = duk_require_lstring(ctx, 0, &sz);
    duk_size_t i;

    /* We're going to need 'sz' additional entries on the stack. */
    duk_require_stack(ctx, cast(duk_idx_t)sz);

    for (i = 0; i < sz; i++) {
        char ch = val[i];
        if (ch >= 'a' && ch <= 'z') {
            ch = cast(char)(ch - 'a' + 'A');
        }
        duk_push_lstring(ctx, cast(const char *)&ch, 1);
    }

    duk_concat(ctx, cast(duk_idx_t)sz);
    return 1;
}

int main(string[] args) {
    if (args.length < 2) { return 1; }

    duk_context *ctx = duk_create_heap_default();
    if (!ctx) {
        writeln("Failed to create a Duktape heap.");
        return 1;
    }

    scope(exit) duk_destroy_heap(ctx);

    duk_push_c_function(ctx, &dummy_upper_case, 1);
    duk_push_string(ctx, args[1].toStringz);
    duk_call(ctx, 1);
    writef("%s -> %s\n", args[1], duk_to_string(ctx, -1).to!string);
    duk_pop(ctx);

    return 0;
}

import std.conv;
import std.stdio;
import std.string;

import duktape;
import duk_extras.v1_compat;

int main() {
    duk_context *ctx = duk_create_heap_default();
    if (!ctx) {
        writeln("Failed to create a Duktape heap.");
        return 1;
    }

    scope(exit) duk_destroy_heap(ctx);

    // toStringz not really needed because D literal strings are null-terminated
    
    if (duk_peval_file(ctx, "process.js".toStringz()) != 0) {
        writef("Error: %s\n", duk_safe_to_string(ctx, -1).to!string);
        return 0;
    }

    duk_pop(ctx); /* ignore result */

    char[] line;
    while (stdin.readln(line)) {
        duk_push_global_object(ctx);

        duk_get_prop_string(ctx, -1 /*index*/, "processLine".toStringz());

        duk_push_string(ctx, line.toStringz());
        if (duk_pcall(ctx, 1 /*nargs*/) != 0) {
            writef("Error: %s\n", duk_safe_to_string(ctx, -1).to!string);
        } else {
            writef("%s\n", duk_safe_to_string(ctx, -1).to!string);
        }

        duk_pop(ctx);  /* pop result/error */
    }

    return 0;
}

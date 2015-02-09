import std.stdio;

import duktape;

extern (C) duk_ret_t my_func_1(duk_context *ctx) {
    writeln("In func1");
    return 1;
}

extern (C) duk_ret_t my_func_2(duk_context *ctx) {
    writeln("In func2");
    return 1;
}

const duk_function_list_entry[3] my_module_funcs = [
    { "func1", &my_func_1, 3 /*nargs*/ },
    { "func2", &my_func_2, DUK_VARARGS /*nargs*/ },
    { null, null, 0 }
];

const duk_number_list_entry[2] my_module_consts = [
    { "FLAG_FOO", cast(double)(1 << 0) },
    { null, 0.0 }
];

/* Init function name is dukopen_<modname>. */
extern (C) duk_ret_t dukopen_my_module(duk_context *ctx) {
    duk_push_object(ctx);
    duk_put_function_list(ctx, -1, &my_module_funcs[0]);
    duk_put_number_list(ctx, -1, &my_module_consts[0]);

    /* Return value is the module object.  It's up to the caller to decide
     * how to use the value, e.g. write to global object.
     */
    return 1;
}

int main() {
    duk_context *ctx = duk_create_heap_default();
    if (!ctx) {
        writeln("Failed to create a Duktape heap.");
        return 1;
    }

    scope(exit) duk_destroy_heap(ctx);

    /* Module loading happens with a Duktape/C call wrapper. */
    duk_push_c_function(ctx, &dukopen_my_module, 0 /*nargs*/);
    duk_call(ctx, 0);
    duk_put_global_string(ctx, "my_module");

    /* my_module is now registered in the global object. */
    duk_eval_string_noresult(ctx, "my_module.func2()");

    /* ... */

    return 0;
}

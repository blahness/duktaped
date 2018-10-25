# D binding to Duktape library #

### Notes ###

This has been used/tested with Duktape 2.3.x on:

* Ubuntu 18.10 x64
* Windows 7 x86 & x64

To run uppercase example:

```
dub run duktape:uppercase -- "this is a test"
```

On Windows you should add --arch=x86_mscoff for 32-bit builds or --arch=x86_64 for 64-bit builds because the included binary files are in COFF format.

```
dub run --arch=x86_64 duktape:uppercase -- "this is a test"
```

For more information about Duktape check out its official website: [http://duktape.org/](http://duktape.org/)

## Examples
```D
// primecheck.d

import std.conv;
import std.stdio;
import std.string;

import duktape;
import duk_extras.print_alert;
import duk_extras.v1_compat;

extern (C) duk_ret_t native_prime_check(duk_context *ctx) {
    int val = duk_require_int(ctx, 0);
    int lim = duk_require_int(ctx, 1);
    int i;

    for (i = 2; i <= lim; i++) {
        if (val % i == 0) {
            duk_push_false(ctx);
            return 1;
        }
    }

    duk_push_true(ctx);
    return 1;
}

int main() {
    duk_context *ctx = duk_create_heap_default();
    if (!ctx) {
        writeln("Failed to create a Duktape heap.");
        return 1;
    }

    scope(exit) duk_destroy_heap(ctx);

    duk_push_global_object(ctx);
    duk_print_alert_init(ctx, 0);
    duk_push_c_function(ctx, &native_prime_check, 2 /*nargs*/);
    duk_put_prop_string(ctx, -2, "primeCheckNative");

    if (duk_peval_file(ctx, "prime.js") != 0) {
        writef("Error: %s\n", duk_safe_to_string(ctx, -1).to!string);
        return 0;
    }
    duk_pop(ctx);  /* ignore result */

    duk_get_prop_string(ctx, -1, "primeTest");
    if (duk_pcall(ctx, 0) != 0) {
        writef("Error: %s\n", duk_safe_to_string(ctx, -1).to!string);
    }
    duk_pop(ctx);  /* ignore result */

    return 0;
}
```

```Javascript
// prime.js

// Pure Ecmascript version of low level helper
function primeCheckEcmascript(val, limit) {
    for (var i = 2; i <= limit; i++) {
        if ((val % i) == 0) { return false; }
    }
    return true;
}

// Select available helper at load time
var primeCheckHelper = (this.primeCheckNative || primeCheckEcmascript);

// Check 'val' for primality
function primeCheck(val) {
    if (val == 1 || val == 2) { return true; }
    var limit = Math.ceil(Math.sqrt(val));
    while (limit * limit < val) { limit += 1; }
    return primeCheckHelper(val, limit);
}

// Find primes below one million ending in '9999'.
function primeTest() {
    var res = [];

    print('Have native helper: ' + (primeCheckHelper !== primeCheckEcmascript));
    for (var i = 1; i < 1000000; i++) {
        if (primeCheck(i) && (i % 10000) == 9999) { res.push(i); }
    } 
    print(res.join(' '));
}
```
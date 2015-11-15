import std.conv;
import std.stdio;
import std.string;

import duktape;

enum {
    MODE_NORMAL,
    MODE_MULTI,
    MODE_PASTE
}

string help_text = "Commands:\n" ~
    "  :help    print this summary\n" ~
    "  :paste   enter/exit paste mode (allows multi-line text entry)\n" ~
    "  :quit    exit the interpreter\n" ~
    "Hints:\n" ~
    "  End line with \\ to continue code on next line.";

void main() {   
    duk_context *ctx = duk_create_heap_default();
    
    writeln("Welcome to the Duktape Javascript console.\n" ~
        "Type in expressions to have them evaluated.\n" ~
        "Type :help for more information.");
    
    string line;
    auto mode = MODE_NORMAL;

    while (true) {
        if (mode == MODE_NORMAL) {
            write("duktape> ");
            line = stdin.readln().stripRight();

            if (line == ":help") {
                writeln(help_text);
                continue;
            } else if (line == ":paste") {
                mode = MODE_PASTE;
                line = "";
                write("// Entering paste mode (:paste to finish)\n");
                continue;
            } else if (line == ":quit") {
                break;
            }

            if (line.endsWith("\\")) {
                line = line.chop() ~ "\n";
                mode = MODE_MULTI;
                continue;
            }

            line ~= "\n";
        } else if (mode == MODE_MULTI) {
            write("       | ");
            line ~= stdin.readln().stripRight();

            if (line.endsWith("\\")) {
                line = line.chop() ~ "\n";
                continue;
            }

            mode = MODE_NORMAL;
            line ~= "\n";
        } else {
            string temp_line = stdin.readln().stripRight();

            if (temp_line == ":paste") {
                mode = MODE_NORMAL;
                write("// Exiting paste mode, now interpreting.\n");
            } else {
                line ~= temp_line ~ "\n";
                continue;
            }
        }

        int ret = duk_peval_lstring(ctx, line.ptr, line.length - 1);
        
        if (ret != 0) {
            writeln("Error: " ~ duk_to_string(ctx, -1).to!string);
        }
        else {
            if (!duk_is_undefined(ctx, -1))
                writeln(duk_to_string(ctx, -1).to!string);
        }
        
        duk_pop(ctx);
    }
    
    duk_destroy_heap(ctx);
}

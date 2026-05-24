import std.mem;
import std.sys;

import chunk;

#pragma endian big

struct Flags {
    u16;
    char language_id[2];
    u16 [[comment("Something to do with encryption.")]];
    u16;
};

char file_signature[4] @ 0x00;
std::assert(file_signature == "NUCC",
    "Mismatched file signature: Expected `NUCC`.");
u32 version @ $;
Flags flags @ $;
NuccIndex index @ $;

NuccChunk<index> chunks[while(!std::mem::eof())] @ $;
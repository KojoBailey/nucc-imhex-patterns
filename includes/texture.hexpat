#pragma endian big

struct NuccTexture {
	u16;
	u16 width;
	u16 height;
	u16;
	u32 size;
	u8 data[size];
};

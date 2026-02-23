#!/bin/bash
# orangepi-zero-llm — build llama.cpp from source on ARMv7
# Tested on: Orange Pi Zero, ARMv7, 512MB RAM, Ubuntu 18.04
# This script documents every flag that was required to build successfully

set -e

echo "📦 Installing dependencies..."
apt-get install -y build-essential

echo "📥 Cloning llama.cpp b1525 (last stable Makefile version)..."
git clone --depth 1 --branch b1525 https://github.com/ggerganov/llama.cpp.git
cd llama.cpp

echo "🔨 Building for ARMv7 (no NEON, vfpv3 only)..."
echo "⏳ This will take 15-30 minutes on ARMv7..."

make main LLAMA_NATIVE=0 \
  MK_CFLAGS="-mfpu=vfpv3 -mfp16-format=ieee" \
  MK_CXXFLAGS="-mfpu=vfpv3 -mfp16-format=ieee" \
  LDFLAGS="-lpthread"

echo "✅ Build complete!"
cp main ../bin/main
echo "📁 Binary copied to bin/main"

# Why these flags?
# LLAMA_NATIVE=0      — disable auto-detection of CPU features (ARMv7 is misdetected)
# -mfpu=vfpv3         — use vfpv3 FPU instead of neon-fp-armv8 (prevents illegal instruction)
# -mfp16-format=ieee  — required for __fp16 type support
# -lpthread           — pthread was not linked automatically on this toolchain

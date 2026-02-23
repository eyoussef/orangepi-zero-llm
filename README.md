# orangepi-zero-llm

> Run a large language model on a $10 board with 500MB RAM. No GPU. No cloud. No nonsense.

This repo provides a **prebuilt llama.cpp binary** for the Orange Pi Zero (ARMv7, 32-bit) so you can run quantized LLMs locally without spending hours fighting the build system.

---

## Tested Hardware

| Spec | Value |
|---|---|
| Board | Orange Pi Zero |
| Architecture | ARMv7 (armv7l, 32-bit) |
| RAM | 512MB |
| OS | Ubuntu 18.04 (armhf) |
| GCC | 7.5.0 |

---

## Quick Start

**1. Clone the repo:**
```bash
git clone https://github.com/eyoussef/orangepi-zero-llm.git
cd orangepi-zero-llm
chmod +x bin/main run.sh
```

**2. Download a model:**
```bash
# TinyLlama 1.1B Q2_K — recommended for 512MB RAM
wget https://huggingface.co/MaziyarPanahi/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q2_K.gguf \
  -O models/TinyLlama-1.1B-Chat-v1.0.Q2_K.gguf
```

**3. Run:**
```bash
./run.sh models/TinyLlama-1.1B-Chat-v1.0.Q2_K.gguf "What is the meaning of life?"
```

---

## Recommended Models

| Model | Size | RAM Required | Notes |
|---|---|---|---|
| TinyLlama-1.1B Q2_K | 411MB | ~450MB | Best balance for 512MB RAM |
| SmolLM2-135M Q4_K_M | 100MB | ~150MB | Fastest, least capable |
| Qwen2.5-0.5B Q4_K_M | 350MB | ~400MB | Good reasoning |

> ⚠️ Always use `-c 128` or `-c 256` context length. Higher values will OOM.

---

## Benchmark

Real numbers from a real Orange Pi Zero:

```
Model:         TinyLlama 1.1B Q2_K
Load time:     142 seconds
Generation:    0.02 tokens/second (~60 sec/token)
Sampling:      12.92 tokens/second
RAM used:      ~430MB
```

This is slow. That is expected. ARMv7 without NEON SIMD does scalar math.  
The point is: **it works**. Intelligence does not require expensive hardware.  
It just requires patience.

---

## Rebuild From Scratch

If you want to compile yourself instead of using the prebuilt binary:

```bash
chmod +x build.sh
./build.sh
```

See `build.sh` for the exact flags that worked on ARMv7.

---

## Why This Exists

Most llama.cpp build guides assume ARM64, x86, or a working Python environment.  
The Orange Pi Zero has none of those things.

After fighting:
- CMake version conflicts
- Broken Python 3.6 pip environment  
- NEON illegal instruction crashes
- pthread linking errors

...the right build flags were found. This repo saves you all of that.

**Read the full story:** [Medium Article →](https://medium.com/@elkamiliyoussef/the-orange-pi-zero-is-not-too-weak-to-be-intelligent-its-just-intelligent-at-its-own-pace-12764855086a)

---

## License

The prebuilt binary is built from [llama.cpp](https://github.com/ggerganov/llama.cpp) (MIT License), branch `b1525`.  
This repo and its scripts are also MIT licensed.

---

*Built by [Youssef El Kamili](https://github.com/eyoussef) — proving that any machine can be intelligent.*

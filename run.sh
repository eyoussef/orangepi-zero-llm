#!/bin/bash
# orangepi-zero-llm — simple inference wrapper
# Usage: ./run.sh [model_path] [prompt]

MODEL=${1:-"models/TinyLlama-1.1B-Chat-v1.0.Q2_K.gguf"}
PROMPT=${2:-"Hello, who are you?"}

if [ ! -f "$MODEL" ]; then
  echo "❌ Model not found: $MODEL"
  echo "👉 Put your .gguf model in the models/ folder"
  exit 1
fi

echo "🤖 Model: $MODEL"
echo "💬 Prompt: $PROMPT"
echo "⏳ Generating (this will be slow on ARMv7 — be patient)..."
echo "---"

./bin/main \
  -m "$MODEL" \
  -p "$PROMPT" \
  -n 50 \
  -t 4 \
  -c 128 \
  --no-display-prompt

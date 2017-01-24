#!/usr/bin/env bash
python generate.py --wav_out_path=generated-animals.wav --samples 128000 logdir/train/animals/model.ckpt-$1

#!/usr/bin/env bash
python ./train.py --data_dir=data/animals --checkpoint_every=10 --restore_from=logdir/train/animals

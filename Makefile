.PHONY: all

REMOTE_HOST ?= ec2-54-174-190-147.compute-1.amazonaws.com
SSH_KEY ?= ~/.ssh/MykhailoZiatin.pem
MODEL_ID ?= 0


train:
	python ./train.py --data_dir=data/animals --checkpoint_every=50 --restore_from=logdir/train/animals

sample: generate-sample mv-generated

generate-sample:
	python generate.py --wav_out_path=generated-animals.wav --samples 128000 logdir/train/animals/model.ckpt-$(MODEL_ID)

mv-generated:
	mv generated-animals.wav /home/ubuntu/

scp-generated:
	scp -i $(SSH_KEY) ubuntu@$(REMOTE_HOST):generated-animals.wav .

scp-animals-model:
	scp -i $(SSH_KEY) ubuntu@$(REMOTE_HOST):animals-model.zip .

download-animals:
	wget https://dl.dropboxusercontent.com/s/t825zr5ytnl22zl/animals-xsmall.zip && \
	unzip animals-xsmall.zip && \
	rm animals-xsmall.zip

download-animals-model:
	wget https://dl.dropboxusercontent.com/s/90wapqa06osge90/animals-model.zip && \
	unzip animals-model.zip && \
	rm animals-model.zip

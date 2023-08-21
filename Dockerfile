FROM python:3.11

# Install miniconda
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
	https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
	&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
	&& rm -f Miniconda3-latest-Linux-x86_64.sh

# Add conda binary to PATH variable
ENV HOME=/home/user \
	PATH=/opt/miniconda3/bin:/home/user/.local/bin:$PATH \
	CONDA_PREFIX=/opt/miniconda3/envs

# Setup conda envs
WORKDIR $HOME/app
COPY . .

# Conda envs setup 
RUN bash ./scripts/EnvsSetup.sh

# pre-download all models
RUN conda run --live-stream -n WavJourney python scripts/download_models.py
RUN mkdir $HOME/app/services_logs

# entrypoint
ENTRYPOINT bash /home/user/app/scripts/start_service_and_ui.sh
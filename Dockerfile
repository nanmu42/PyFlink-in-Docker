FROM flink:1.13.1
# copy from https://hub.docker.com/r/continuumio/miniconda3/dockerfile
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean --all -y && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
# use bash(with --login) instead of sh to make ~/.bashrc works
SHELL ["/bin/bash", "--login", "-c"]
# now conda base env is activated by default
RUN pip install apache-flink==1.13.1 && \
    pip cache purge
COPY docker-entrypoint.sh python.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
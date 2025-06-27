FROM ubuntu:20.04

#############################################################################
# Requirements
#############################################################################

RUN \
  apt-get update -y && \
  apt-get install -y \
    python3.8 \
    python3.8-venv \
    python3-pip \
    git \
    build-essential \
    dos2unix \
    wget \
    curl \
    && \
  rm -rf /var/lib/apt/lists/*

# Set Python 3.8 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

# Timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#############################################################################
# Setup BugsInPy
#############################################################################

# Copy the BugsInPy project
WORKDIR /bugsinpy
COPY . /bugsinpy/

# Make the bin scripts executable
RUN chmod +x /bugsinpy/framework/bin/*

# Add BugsInPy executables to PATH
ENV PATH="/bugsinpy/framework/bin:${PATH}"

# Create a directory for temporary work
RUN mkdir -p /bugsinpy/framework/bin/temp

# Install common Python packages
RUN pip3 install --upgrade pip setuptools wheel six pytest python_toolbox backoff future decorator pandas unidiff

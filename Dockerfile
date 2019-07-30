# RPM Build Env for nanocurrency projects
FROM centos:centos7
MAINTAINER Russel Waters <russel@nano.org>


RUN yes | yum update -y
RUN yes | yum install -y git wget openssl bzip2
RUN yes | yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yes | yum install -y jq rpm-build
RUN yes | yum install -y glibc-devel glibc-headers make which libstdc++-static
RUN yes | yum install -y centos-release-scl
RUN yes | yum install -y llvm-toolset-7-cmake devtoolset-7-llvm

RUN wget --quiet -O boost_1_70_0.tar.bz2 https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.bz2
RUN tar xf boost_1_70_0.tar.bz2

RUN scl enable llvm-toolset-7 devtoolset-7
RUN pushd boost_1_70_0 && \
    ./bootstrap.sh --with-libraries=thread,log,filesystem,program_options --with-toolset=clang && \
    ./b2 --prefix=/usr/local link=static toolset=clang install

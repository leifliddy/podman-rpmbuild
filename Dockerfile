FROM registry.fedoraproject.org/fedora:37

ENV  mock_user mock.user
COPY files/bashrc /root/.bashrc
COPY files/rpmmacros /root/.rpmmacros

RUN dnf upgrade -y &&\
    dnf install -y bash-completion bzip2 diffutils dnf-utils file findutils gcc git mock pyproject-rpm-macros rpm-build rsync vim-enhanced wget which xz zip &&\
    mkdir /root/.bashrc.d &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo 'defaultyes=True' >> /etc/dnf/dnf.conf &&\
    useradd $mock_user &&\
    usermod -aG wheel $mock_user &&\
    usermod -aG mock $mock_user

COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild

# set login directory
WORKDIR /root

CMD ["/bin/bash"]

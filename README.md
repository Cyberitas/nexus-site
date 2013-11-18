# Nexus site deployment
Provisions and deploys a [Sonatype Nexus] artifact repository

## Overview
Credentials for the default admin user are ```admin/admin123```

System is accessible locally at ```192.168.2.20:8081/nexus```

## Dev/local usage
[Vagrant] is used for dev/local usage, testing and experimentation. Simply run ```vagrant up``` to provision a new
Nexus site.

## Known issues:
### Yum Plugin and Secured Repositories
Version 3.0.4 of the [yum-plugin] distributed with [Nexus 2.6.3][Sonatype Nexus] has an issue with secured
(i.e. private) repositories.  Yum clients cannot fetch artifacts from a secured repository which may be related to
a [bug](https://bugzilla.redhat.com/show_bug.cgi?id=739860) in the pycurl library used by Yum.

#### Reproduction
1. Disable the anonymous user or otherwise disable public access to a repository
1. Add the ```Generate Metadata``` capability to a private repository
1. Deploy an rpm to the repository
1. verify metadata was created (e.g. http://192.168.2.20:8081/nexus/content/repositories/releases/repodata/repomd.xml)
1. On your yum client add a repo yaml (under /etc/yum.repos.d on this system)
    ```
    [sample_yum_conf]
    name=Sample Site
    baseurl=http://admin:admin123@192.168.2.20:8081/nexus/content/repositories/releases
    username=admin
    password=admin123
    enabled=1
    gpgcheck=0
    metadata_expire=30s
    autorefresh=1
    protect=0
    type=rpm-md
    ```
1. run ```yum search <rpm name>``` -- this will succeed
1. run ```yum clean all && yum install <rpm name>``` -- this fails.

#### Work-around
A new nexus-yum-plugin jar was built from the [Yum plugin source][yum-plugin] with the [--baseurl line][yum-removed-line]
removed.  This generates a ```repomd.xml``` file without the baseurl and lets yum construct the absolute url with
username and password params.  RPMs already in the repo will have to be removed and manually re-added or createrepo will
need to be run manually to work-around this issue.

#### Bug
A bug has been filed with Nexus: https://issues.sonatype.org/browse/NEXUS-6122

[Sonatype Nexus]: http://www.sonatype.org/nexus/
[Vagrant]: http://vagrantup.com
[yum-plugin]: https://github.com/sonatype/nexus-yum-plugin/
[yum-removed-line]: https://github.com/sonatype/nexus-yum-plugin/blob/fdaf85f9d98ed701c7bc7be2ca6df1b37aed36e1/nexus-yum-plugin/src/main/java/org/sonatype/nexus/yum/internal/task/GenerateMetadataTask.java#L322

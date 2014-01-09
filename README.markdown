# Nexus

## Overview

This is the nexus module. It enables us to create nexus instances and obtain maven artifacts from nexus instances

## Module Description

This module will enable us to define new nexus instances by obtaining the latest nexus war file from an existing nexus instance.

You can also obtain any arbitary maven artifact from a nexus instance 

## Setup

### What Nexus affects

* Installs an instance of tomcat
* Downloads maven artifacts to the /tmp directory

## Usage

Create a new nexus instance from an artifact hosted in the default nexus instance.
    
    include nexus::server

Obtain the latest maven artifact from nexus

    nexus::artifact {
        group    => 'any.old.group',
        artifact => 'uberduber-webapp',
    }

## Limitations

You will need to have a nexus instance manually defined in order to create new nexus instances. At the moment this is a manual process, however we should define a class which allows us to deploy an instance of nexus from a war file hosted on the puppet master. This will be of use if the nexus instance is destroyed, or the rest api of nexus is no longer compatible with this puppet module.

This module has been tested on ubuntu 12.04 lts

## Contributors

Christopher Johnson - cjohn@ceh.ac.uk
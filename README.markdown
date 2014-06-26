# Nexus

## Overview

This is the nexus module. It enables us to obtain maven artifacts from nexus instances

## Module Description

You can obtain any arbitary maven artifact from a nexus instance 

## Setup

### What Nexus affects

* Downloads maven artifacts to the /tmp directory

## Usage

Obtain the latest maven artifact from nexus

    nexus::artifact {
        group    => 'any.old.group',
        artifact => 'uberduber-webapp',
    }

## Limitations

This module has been tested on ubuntu 12.04 lts

## Contributors

Christopher Johnson - cjohn@ceh.ac.uk
#!/bin/bash

swupd bundle-add kernel-lts
clr-boot-manager set-timeout 10
clr-boot-manager update

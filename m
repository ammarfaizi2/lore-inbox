Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSHDUWA>; Sun, 4 Aug 2002 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSHDUWA>; Sun, 4 Aug 2002 16:22:00 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:7278 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S318204AbSHDUV6>; Sun, 4 Aug 2002 16:21:58 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
Organization: Linux Kernel -jp http://infolinux.de
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] Linux 2.4.19-jp14
Date: Sun, 4 Aug 2002 22:24:06 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208042224.06484.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel patch set 2.4.19-jp14

This is the fourteenth release of the -jp patch set.

What is it?

The -jp kernel patch sets are development kernels for testing purpose only. 
They provide a service for developers who can't keep up to date with the 
latest kernel and interesting patches at the various places in the net. 
For those peoples who like to test interesting new features of large patches 
and evaluate bleeding-edge enhancements not to be expected for inclusion 
into the standard 2.4 kernel in the near future, the -jp kernel patch set 
offers an alternative.

Many thanks to all patch developers for the great work.

Download

http://infolinux.de/jp14

The patch set is provided as a single archive where you will find all patches 
as separate files. 

Content

000_amd-cache-fix                             046_i8k-1.13
001_gcc-3.1-fix                               047_tux2-remove-khttpd
002_no-warnings                               048_tux2-final-A3
003_lkml-quick-fixes                          049_nfs-2.4.19-rc4
004_jiffies-for-i386-2                        050_nfs-over-tcp
005_cpufreq                                   051_ext3-cvs
006_cpufreq-26Jul2002                         052_xfs-2.4.19-split-only
007_p4-xeon                                   053_xfs-2.4.19-split-xattr
008_sis740-961                                054_xfs-2.4.19-split-kernel
009_TIOCGDEV                                  055_xfs-2.4.19-split-quota32
010_via-northbridge-fixup                     056_xfs-2.4.19-split-kbuild-2.5
011_vm-rmap-13-2                              057_xfs-2.4.19-split-dmapi
012_vm-rmap-13a                               058_xfs-2.4.19-split-misc
013_vm-rmap-13a-13b                           059_xfs-2.4.19-split-ia64
014_sched-O1-rml-2.4.19-rc1-1                 060_xfs-2.4.19-jp14-adapt
015_preempt-kernel-rml-2.4.19-rc3-ac5-1-rmap  061_jfs-1.0.20
016_preempt-lock-break                        062_jfs-adapt
017_lowlatency-mini                           063_ftpfs-0.6.2
018_lowlatency-fixes-5                        064_ftpfs-fixups
019_pagecache-radix-tree                      065_cdfs-0.5b
020_ide-all-convert-10-2                      066_cdfs-0.5c
021_block-tag-2.4.19pre8                      067_befs-0.92
022_block-tag-2                               068_ntfs-22a
023_ide-tag-2.4.19pre8                        069_ncpfs-fix
024_ide-tag-2                                 070_shared-zlib
025_ide-cd-dma-4                              071_patch-int-2.4.18.3
026_raid-md-locks-2                           072_loop-jari-2.4.18.0
027_raid-split                                073_freeswan-snapshot-2002aug03g
028_raid-mdp-major                            074_grsecurity-1.9.6
029_raid-md-part                              075_grsecurity-1.9.6-tux-adapt
030_supermount-autofs4                        076_nmap-freak
031_supermount-isrdonly                       077_alsa-remove-oss-2.4.19
032_supermount-new-stat-4                     078_alsa-remove-oss-2.4.18
033_supermount-mediactl                       079_alsa-remove-oss-core
034_supermount-llseek                         080_alsa-0.9.0rc1
035_supermount-mount                          081_alsa-2.5.17-cs1.582
036_supermount-device                         082_alsa-adapt-2
037_supermount-supermount                     083_kbuild25-3.0
038_supermount-fix                            084_kbuild-alsa
039_scsi-dc395x-1.40                          085_kbuild-crypto
040_usbdnet-0.4b                              086_kbuild-scsi-dc395x
041_i2c-2.6.4                                 087_kbuild-ratcache-adapt
042_i2c-fixes                                 088_kbuild-rtc-fix
043_lm-sensors-2.6.4                          089_kbuild-acpi-adapt
044_acpi-20020726                             100_VERSION
045_acpi-include-dir

For more information, please visit http://infolinux.de

   Kind regards,

       Jörg Prante <joerg@infolinux.de>



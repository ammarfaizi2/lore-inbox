Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318465AbSGSEow>; Fri, 19 Jul 2002 00:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318466AbSGSEow>; Fri, 19 Jul 2002 00:44:52 -0400
Received: from mail.adiglobal.com ([66.207.47.93]:5126 "EHLO
	mail.adiglobal.com") by vger.kernel.org with ESMTP
	id <S318465AbSGSEon>; Fri, 19 Jul 2002 00:44:43 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jul 2002 00:47:37 -0400
MIME-Version: 1.0
Subject: [2.6] The List, pass #2
Message-ID: <3D3761A9.23960.8EB1A2@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reorganized the list into 5 categories based on the feedback 
I received.  Now let's see what happens  :-)

In line with your expectations?

-- Guillaume


----------------------------------------------------
Likely to be merged before feature freeze:

  o New VM with reverse mappings
  o Add Linux Security Module (LSM)
  o New MTRR (Memory Type Range Register) driver
  o Add support for CPU clock/voltage scaling
  o Add User-Mode Linux (UML)
  o Direct pagecache <-> BIO disk I/O
  o Fix device naming issues
  o Remove the 2TB block device limit 

----------------------------------------------------
"The pressure is on! (TM)":
(either gets merged before feature freeze or has to wait till 2.7)

  o Rewrite of the console layer                    
  o XFS (A journaling filesystem from SGI)
  o LVM (Logical Volume Manager) v2.0
  o Zerocopy NFS
  o Asynchronous IO (aio) support
  o New kernel build system (kbuild 2.5)
  o Serial driver restructure                       
  o Replace initrd by initramfs
  o ext2/ext3 large directory support: HTree index

----------------------------------------------------
Can be merged after the feature freeze and before the 2.6 release:

  o Strict address space accounting                 
  o More complete NetBEUI stack                     
  o Add hardware sensors drivers                    
  o PCMCIA Zoom video support               
  o Change all drivers to new driver model
  o UDF Write support for CD-R/RW (packet writing)
  o USB gadget support

----------------------------------------------------
Would be nice to have before feature freeze, but most likely 2.7:

  o Improved i2o (Intelligent Input/Ouput) layer
  o Read-Copy Update Mutual Exclusion
  o New IO scheduler
  o Per-mountpoint read-only, union-mounts, unionfs
  o EVMS (Enterprise Volume Management System)
  o Dynamic Probes
  o Page table sharing
  o ext2/ext3 online resize support
  o Better event logging for enterprise systems
  o UMSDOS (Unix under MS-DOS) Rewrite
  o Scalable Statistics Counter
  o Linux Kernel Crash Dumps
  o SCTP (Stream Control Transmission Protocol)
  o High resolution timers
  o Overhaul PCMCIA support
  o Reiserfs v4
  o New lightweight library (klibc)
  o New mount API
  o Generic parameter/command line interface
  o Full compliance with IPv6
  o Serial ATA support      
  o Add support for NFS v4

----------------------------------------------------
Definitely 2.7:

o InfiniBand support
o Add thrashing control
o Remove all hardwired drivers from kernel


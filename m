Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSKFVKK>; Wed, 6 Nov 2002 16:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266111AbSKFVKK>; Wed, 6 Nov 2002 16:10:10 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:929 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S266108AbSKFVKI>; Wed, 6 Nov 2002 16:10:08 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Nov 2002 16:15:43 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  November 6, 2002
Message-ID: <3DC9402F.22787.27763DD6@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [64.152.17.166] at Wed, 6 Nov 2002 15:16:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Halloween behind us, I have regrouped all the remaining items on 
the status list into 2 categories: 2.6 and post-2.6.
I'd be great if folks in the know could comment on the relevance of 
the breakdown!

The full list is at http://www.kernelnewbies.org/status/
Enjoy!

-- Guillaume

--------------------------
Linux Kernel 2.5 Status - November 6th, 2002
(Latest kernel release is 2.5.46)

Merged  
....
o in 2.5.45  CryptoAPI  (James Morris)  
o in 2.5.45  New Linux configuration system: kconfig  (Roman Zippel)  
o in 2.5.46  Extended Attributes and ACLs for ext2/ext3  (Ted Ts'o)  
o in 2.5.46  Replace initrd by initramfs  (H. Peter Anvin, Al Viro, Jeff Garzik)  
o in 2.5.46  MMU-less processor support (ucLinux)  (Greg Ungerer)  
o in 2.5.46  Better I/O performance with epoll  (Davide Libenzi)  
 
o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken)  
o in -mm  Per-cpu hot & cold page lists  (Andrew Morton, Martin Bligh)  
o in -dcl  EVMS (Enterprise Volume Management System)  (EVMS team)  
o in -dcl  Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
o in -dcl  Linux Kernel Crash Dumps  (Matt Robinson, LKCD team)  
o in -dcl  NUMA aware scheduler extensions  (Erich Focht, Michael Hohnbaum)  
 
o in 2.6  Kernel Probes (kprobes)  (Vamsi Krishna, kprobes team)  
o in 2.6  High resolution timers  (George Anzinger, etc.)  
o in 2.6  Rewrite of the console layer  (James Simmons)  
o in 2.6  Zerocopy NFS  (Hirokazu Takahashi)  
o in 2.6  Support insane number of groups  (Tim Hockin)  
o in 2.6  SCSI and FibreChannel Hotswap Support  (Steven Dake)  
o in 2.6  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji 
Hideaki, USAGI team)  
o in 2.6  Reiserfs v4  (Reiserfs team)  
o in 2.6  32bit dev_t  (?)  
o in 2.6  UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)  
o in 2.6  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o in 2.6  Change all drivers to new driver model  (All maintainers)  
o in 2.6  USB gadget support  (Stuart Lynne, Greg Kroah-Hartman)  
o in 2.6  Improved AppleTalk stack  (Arnaldo Carvalho de Melo)  
o in 2.6  ext2/ext3 online resize support  (Andreas Dilger)  
 
o post 2.6  Kexec, syscall to load kernel from kernel  (Eric Biederman)  
o post 2.6  In-kernel module loader  (Rusty Russell)  
o post 2.6  Unified boot/parameter support  (Rusty Russell)  
o post 2.6  SCSI multipath IO (with NUMA support)  (Patrick Mansfield, Mike Anderson)  
o post 2.6  Basic NUMA API  (Matt Dobson)  
o post 2.6  Remove waitqueue heads from kernel structures  (William Lee Irwin)  
o post 2.6  NUMA aware slab allocator  (Manfred Spraul, Martin Bligh)  
o post 2.6  Better event logging for enterprise systems  (Larry Kessler, evlog team)  
o post 2.6  Page table reclamation  (William Lee Irwin, Rik Van Riel)  
o post 2.6  UMSDOS (Unix under MS-DOS) Rewrite  (Al Viro)  
o post 2.6  Overhaul PCMCIA support  (David Woodhouse, David Hinds)  
o post 2.6  InfiniBand support  (InfiniBand team)  
o post 2.6  Per-mountpoint read-only, union-mounts, unionfs  (Al Viro)  
o post 2.6  More complete NetBEUI stack  (Arnaldo Carvalho de Melo, from Procom donated code)  
o post 2.6  New mount API  (Al Viro)  
o post 2.6  Add thrashing control  (Rik van Riel)  
o post 2.6  Remove all hardwired drivers from kernel  (Alan Cox, etc.)  
o post 2.6  New lightweight library (klibc)  (H. Peter Anvin)  
o post 2.6  Scalable Statistics Counter  (Ravikiran Thirumalai)  
o post 2.6  Add hardware sensors drivers  (lm_sensors team)  


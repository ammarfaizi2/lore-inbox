Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSGSFDp>; Fri, 19 Jul 2002 01:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSGSFDo>; Fri, 19 Jul 2002 01:03:44 -0400
Received: from nameservices.net ([208.234.25.16]:34635 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S315760AbSGSFDn>;
	Fri, 19 Jul 2002 01:03:43 -0400
Message-ID: <3D379EC1.CFB94DEE@opersys.com>
Date: Fri, 19 Jul 2002 01:08:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Guillaume Boissiere <boissiere@adiglobal.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <3D3761A9.23960.8EB1A2@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given the interest shown the last time you thought about removing
it, I think it would be appropriate to add LTT back again.

Cheers,

Karim

Guillaume Boissiere wrote:
> 
> I've reorganized the list into 5 categories based on the feedback
> I received.  Now let's see what happens  :-)
> 
> In line with your expectations?
> 
> -- Guillaume
> 
> ----------------------------------------------------
> Likely to be merged before feature freeze:
> 
>   o New VM with reverse mappings
>   o Add Linux Security Module (LSM)
>   o New MTRR (Memory Type Range Register) driver
>   o Add support for CPU clock/voltage scaling
>   o Add User-Mode Linux (UML)
>   o Direct pagecache <-> BIO disk I/O
>   o Fix device naming issues
>   o Remove the 2TB block device limit
> 
> ----------------------------------------------------
> "The pressure is on! (TM)":
> (either gets merged before feature freeze or has to wait till 2.7)
> 
>   o Rewrite of the console layer
>   o XFS (A journaling filesystem from SGI)
>   o LVM (Logical Volume Manager) v2.0
>   o Zerocopy NFS
>   o Asynchronous IO (aio) support
>   o New kernel build system (kbuild 2.5)
>   o Serial driver restructure
>   o Replace initrd by initramfs
>   o ext2/ext3 large directory support: HTree index
> 
> ----------------------------------------------------
> Can be merged after the feature freeze and before the 2.6 release:
> 
>   o Strict address space accounting
>   o More complete NetBEUI stack
>   o Add hardware sensors drivers
>   o PCMCIA Zoom video support
>   o Change all drivers to new driver model
>   o UDF Write support for CD-R/RW (packet writing)
>   o USB gadget support
> 
> ----------------------------------------------------
> Would be nice to have before feature freeze, but most likely 2.7:
> 
>   o Improved i2o (Intelligent Input/Ouput) layer
>   o Read-Copy Update Mutual Exclusion
>   o New IO scheduler
>   o Per-mountpoint read-only, union-mounts, unionfs
>   o EVMS (Enterprise Volume Management System)
>   o Dynamic Probes
>   o Page table sharing
>   o ext2/ext3 online resize support
>   o Better event logging for enterprise systems
>   o UMSDOS (Unix under MS-DOS) Rewrite
>   o Scalable Statistics Counter
>   o Linux Kernel Crash Dumps
>   o SCTP (Stream Control Transmission Protocol)
>   o High resolution timers
>   o Overhaul PCMCIA support
>   o Reiserfs v4
>   o New lightweight library (klibc)
>   o New mount API
>   o Generic parameter/command line interface
>   o Full compliance with IPv6
>   o Serial ATA support
>   o Add support for NFS v4
> 
> ----------------------------------------------------
> Definitely 2.7:
> 
> o InfiniBand support
> o Add thrashing control
> o Remove all hardwired drivers from kernel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

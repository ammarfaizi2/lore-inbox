Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266231AbSKFXkI>; Wed, 6 Nov 2002 18:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266232AbSKFXkI>; Wed, 6 Nov 2002 18:40:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266231AbSKFXkG>;
	Wed, 6 Nov 2002 18:40:06 -0500
Subject: [ANNOUNCE] linux-2.5.46-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Cc: dcl_info@osdl.org, dcl_discussion@osdl.org, dev@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 15:46:44 -0800
Message-Id: <1036626404.20740.169.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest release is available on SourceForge 
   http://sourceforge.net/projects/osdldcl 
or public BitKeeper repository is bk://bk.osdl.org/dcl-2.5


Linux 2.5.46-dcl1

 * Update to Linux Trace Toolkit (LTT)		(Karim Yaghmour)

 * Linux Kernel Crash Dumps			(Matt Robinson, LKCD team)

 * NUMA scheduler enhancements			(Erich Focht, Michael Hohnbaum)

 * Posix timers (not hires)			(George Anzinger)

 * Dcache Read-Copy-Update			(Maneesh Soni)

 * Kernel Config storage			(Khalid Aziz, Randy Dunlap,
						 Steve Hemminger)

 * DAC960 driver fixes				(Dave Olien)

 - Dropped EVMS
	inclusion of device mapper and planned LVM2
	re-evaluating based on current status.
 
 - Dropped vsyscall gettimeofday
	booting problems

 * Trivial fixes expected inclusion in 2.5.47
	binfmt_aout module	(Olaf Dietsche)
	jfs compile error	(Steve Best)
	binutils requirement	(Kai Germaschewski)
	megaraid update		(Mike Anderson, Matt Domsch, Mark Havercamp, 
				 Steve Hemminger)
	pmtu compile errors	(Dave Hollis)
	epoll			(Dave Libenzi, Jay Vosburgh)
	disk statistics		(Lev Makhlis)

Linux 2.5.44-dcl1

 * Update to scsi shutdown fix		(Mike Anderson)

 * Linux Trace Toolkit (LTT)		(Karim Yaghmour)

 * Vsyscall gettimeofday		(John Stultz)

 * Update to Linux Kernel Crash Dumps	(Matt Robinson, LKCD team)

 * Update to EVMS

Linux 2.5.44-dcl1

 * Trivial build related fixes:
	Fix net/ipv4/raw.c build problem	(many)
	Fix qlogic1280 build 			(Jens Axboe)
	Fix megaraid build			(Mike Anderson, Matt Domsch)
	Fix scsi shutdown			(Patric Mansfield)
	
 * Linux Kernel Crash Dump (LKCD)
	Matt Robinson <yakker@aparity.com>

 * Enterprise Volume Manager (EVMS) 
	Mark Peloquin, Steve Pratt, Kevin Corry
	peloquin@us.ibm.com, slpratt@us.ibm.com, corryk@us.ibm.com
	evms-devel@lists.sourceforge.net
	http://www.sourceforge.net/projects/evms/

 * NUMA scheduler enhancements
	Michael Hohnbaum <hohnbaum@us.ibm.com>

 * Kernel Config storage
        Khalid Aziz <khalid@hp.com>
	Randy Dunlap <rddunlap@osdl.org>

 * DAC960 driver fixes
	Dave Olien <dmo@osdl.org>


Getting Involved
----------------
If interested in development of DCL, please subscribe to dcl_discussion
mailing list at http://lists.osdl.org/mailman/listinfo

This kernel has been built and run on a small set of machines, SMP
and UP. Testers are encouraged to exercise the features especially on
large SMP and NUMA architectures.  If a problem is found, please
compare the result with a standard 2.5.46 kernel.  Please report any
problems or successes to the mailing list.

Developers are encouraged to send any enhancements or bug fixes
patches. Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.






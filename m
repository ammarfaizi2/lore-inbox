Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSBGJSX>; Thu, 7 Feb 2002 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSBGJSN>; Thu, 7 Feb 2002 04:18:13 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:22656 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S286750AbSBGJR4>;
	Thu, 7 Feb 2002 04:17:56 -0500
Subject: [ANNOUNCE] 2.4.18-pre8-mjc
From: Michael Cohen <lkml@ohdarn.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 04:17:54 -0500
Message-Id: <1013073474.3684.3.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the -mjc branch has been released.  It is
available at:
	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/patch-2.4.18-pre8-mjc.bz2

This latest release is an immense performance enhancement. :)
--------------------------------------------------------------
(I lost a bunch of my original patches with credits for some of the code
listed here.  This is a complete list, however, of all the code in this 
release of the -mjc branch.)


2.4.18-pre7-ac3				(Alan Cox et al)
Reverse Mapping VM Patch #12c		(Rik van Riel)
No Buffer Wait Patch			(RvR)
O(1) Scheduler K2			(Ingo Molnar)
IRQrate					(IM)
Preemptible Kernel Patch		(Robert M. Love)
Break Selected Locks			(RML)
Fibonacci Hashing: (prime for 32-bit)	(William Lee Irwin III)
-Inode hash				(WLI)
-Page cache hash			(WLI)
-UID hash (dynamic)			(WLI)
-PID hash (dynamic)			(WLI)
OOM trigger increase			(WLI)
Change VM policy to overcommit		(WLI)
Page aging adjustments			(WLI)
Swap-storm prevention (hysterisis)	(WLI)
Netfilter Header Order Fix		(WLI)
proc_pid_statm() cleanup		(WLI)
task_nice export			(WLI)
Bootmem Rewrite				(WLI)
Mountcache size reduction		(WLI, Andi Kleen, Al Viro)
Slab search optimization		(Momchil Velikov)
Radix tree page cache search		(MV)
Cross Compile fix on GCC3		(MV)
Volatile xtime				(MV)
UserMode Linux				(Jeff Dike)
Loop Mounting Deadlock Fix		(Andrew Morton)
Read Latency Fix #2			(AKPM)
slab cache estimate optimization	(Balbir Singh)
x86 Syscall stall fix			(Alexander Khripin)
Pollselect speedup			(Manfred Spraul)
Bdflush parameters			(Stephen van der Krantz)
ECC Memory				(linux-ecc)
-config option et al			(me)
Nanosleep				(?)
mmap -ENOMEM fix			(?)
x86 fast pte				(?)
cache flush update			(?)
TCP Connection Tracking update		(?)
AMD Elan Updates			(Robert Schwiebel)
binfmt_elf checks			(?)
3.5GB Address Space			(?)
SiS5513 updates				(?)
RivaFB Software Blanking		(?)
Rage128 Update				(?)
lm_sensors				(lm_sensors team)
AMD vcool patch				(Daniel Nofftz)
ia64 DMA update				(?)
proc-file-read documentation		(Thomas Hood)

------
Michael J. Cohen
OhDarn.net


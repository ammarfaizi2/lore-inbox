Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSBNE66>; Wed, 13 Feb 2002 23:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289730AbSBNE6t>; Wed, 13 Feb 2002 23:58:49 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:40576 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S289727AbSBNE6a>;
	Wed, 13 Feb 2002 23:58:30 -0500
Subject: Linux 2.4.18-pre9-mjc2
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 13 Feb 2002 23:58:28 -0500
Message-Id: <1013662709.6671.16.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the -mjc branch has been released.  It is
available at:
	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/patch-2.4.18-pre9-mjc2.bz2
--------------------------------------------------------------
[ A great deal of patches have been removed, in interest of keeping this
branch as close to the standard 2.4 series as possible.]
[ I am now using bitkeeper, and my bk tree is available at
bk://ohdarn.net/linux-mjc.  it is cloned from linus's 2.4 tree so
please, please, please clone from him and pull from me. ]


2.4.18-pre9-ac3				(Alan Cox et al)
Reverse Mapping VM Patch #12e		(Rik van Riel)
O(1) Scheduler K3			(Ingo Molnar)
IRQrate					(IM)
Preemptible Kernel Patch		(Robert M. Love)
Break Selected Locks			(RML)
Netdev-Random				(RML)
Fibonacci Hashing: (prime for 32-bit)	(William Lee Irwin III)
-Inode hash				(WLI)
-Page cache hash			(WLI)
-UID hash (dynamic)			(WLI)
-PID hash (dynamic)			(WLI)
OOM trigger increase			(WLI)
Change VM policy to overcommit		(WLI)
Page aging adjustments			(WLI)
Netfilter Header Order Fix		(WLI)
proc_pid_statm() cleanup		(WLI)
task_nice export			(WLI)
Bootmem Rewrite				(WLI)
Mountcache size reduction		(WLI, Andi Kleen, Al Viro)
Slab search optimization		(Momchil Velikov)
Radix tree page cache search		(MV)
UserMode Linux				(Jeff Dike)
Loop Mounting Deadlock Fix		(Andrew Morton)
Read Latency Fix #2			(AKPM)
CDDA DMA fix				(AKPM)
82Cxx devexit				(AKPM)
make request				(AKPM)
slab cache estimate optimization	(Balbir Singh)
x86 Syscall stall fix			(Alexander Khripin)
Bdflush parameters			(Stephen van der Krantz)
AMD Elan Updates			(Robert Schwiebel)
SiS5513 updates	(20020128_1)		(Daniel Bouton)
lm_sensors				(lm_sensors team)
Verbose BUG()				(Hugh Dickins)
Xconfig help fix			(Olaf Diestche)
V4L2					(V4L2 Team)
SCSI CD Changer				(?)



------
Michael J. Cohen
OhDarn.net


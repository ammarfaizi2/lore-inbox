Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSHJSMD>; Sat, 10 Aug 2002 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSHJSMD>; Sat, 10 Aug 2002 14:12:03 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:39047 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317148AbSHJSMA>;
	Sat, 10 Aug 2002 14:12:00 -0400
Date: Sat, 10 Aug 2002 13:09:37 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Report Status
Message-ID: <Pine.LNX.4.44.0208101252160.10605-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've ordered a couple of extra IDE disks and removable drive caddies to 
test "stock" 2.5 IDE and floppy code.  I should have a system I can 
destroy about mid-week.  

The daily updated version of this status report can be found at:
http://members.cox.net/tmolina/kernprobs/status.html

Items marked closed with a kernel version have not had recent comments.  
They will be archived when Linus issues the next version of 2.5.X.


   Notes:
   The sigmask problem is marked closed. Linus has spoken and I've 
appended his remarks.

   The  state of the IDE subsystem in 2.5 is in too much of a flux for 
tracking problems to be fruitful. I probably won't
   add any new ones until feature freeze unless specifically requested.

   Floppy support is currently broken in 2.5. Higher priority items are 
delaying work on a fix.

              Kernel Problem Reports as of 10 Aug
   Problem Title                     Status       Discussion
   RAID                              closed       2.5.28
   RAID 0 BIO problem                open         06 Aug 2002
   OOPS with date                    closed       2.5.28
   cpqarray broken since 2.5.19      closed       2.5.28
   schedule() with irqs disabled!    open         08 Aug 2002
   ISDN broken?                      closed       2.5.28
   bonding driver failure in 2.5     open         2.5.29
   serial oops                       proposed fix 2.5.29
   NUMA-Q minimal workaround updates open         2.5.29
   PnP BIOS problem                  open         3 Aug 2002
   New connections stall             open         2.5.29
   JFS oops                          open         2.5.29
   serial core on embedded PPC       open         2.5.29
   handle_scancode oops              open         2.5.29
   spinlock deadlock                 open         2.5.29
   smp cpu problem                   open         2.5.29
   sigmask problem                   closed       2.5.30
   LTP process_stress causes oops    open         02 Aug 2002
   pdc20265 boot problem             open         09 Aug 2002
   elv_queue_empty oops              open         01 Aug 2002
   Page Writeback oops               open         04 Aug 2002
   slab BUG                          open         03 Aug 2002
   pmd_page problem                  open         04 Aug 2002
   vga console problem               open         04 Aug 2002
   P200MMX boot problem              open         07 Aug 2002
   io apic problem                   open         08 Aug 2002
   dcache oops                       open         09 Aug 2002
   vm86 oops                         open         10 Aug 2002



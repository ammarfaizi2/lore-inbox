Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHYLYJ>; Sun, 25 Aug 2002 07:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHYLYJ>; Sun, 25 Aug 2002 07:24:09 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:41859 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317257AbSHYLYI>;
	Sun, 25 Aug 2002 07:24:08 -0400
Date: Sun, 25 Aug 2002 06:21:46 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Status Report
Message-ID: <Pine.LNX.4.44.0208250617520.4958-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Notes:

   Off-list  email  sent to me regarding these reports is much 
appreciated. Relevant comments to a problem report will be
   added to the discussion thread unless specifically requested not to. If 
you do send me a comment, please CC the list.

   The  state of the IDE subsystem in 2.5 is in too much of a flux for 
tracking problems to be fruitful. I probably won't
   add any new ones until feature freeze unless specifically requested.

   Floppy support is currently broken in 2.5. Higher priority items are 
delaying work on a fix.

                2.5 Kernel Problem Reports as of 25 Aug
   Problem Title                     Status                Discussion
   RAID 0 BIO problem                no further discussion 2.5.30
   schedule() with irqs disabled!    open                  24 Aug 2002
   schedule in interrupt             open                  21 Aug 2002
   bonding driver failure in 2.5     closed                2.5.30
   serial oops                       closed                2.5.30
   NUMA-Q minimal workaround updates closed                2.5.30
   PnP BIOS problem                  closed                2.5.30
   New connections stall             closed                2.5.30
   JFS oops                          open                  19 Aug 2002
   serial core on embedded PPC       closed                2.5.30
   handle_scancode oops              closed                2.5.30
   spinlock deadlock                 closed                2.5.31
   smp cpu problem                   closed                2.5.30
   LTP process_stress causes oops    no further discussion 2.5.30
   elv_queue_empty oops              no further discussion 2.5.30
   Page Writeback oops               no further discussion 2.5.30
   slab BUG                          no further discussion 2.5.30
   pmd_page problem                  no further discussion 2.5.30
   vga console problem               no further discussion 2.5.30
   P200MMX boot problem              no further discussion 2.5.30
   io apic problem                   no further discussion 2.5.30
   dcache oops                       no further discussion 2.5.30
   vm86 oops                         no further discussion 2.5.30
   modules don't work                closed                12 Aug 2002
   unmount oops                      open                  12 Aug 2002
   usb problem                       open                  11 Aug 2002
   pte.chain BUG                     open                  22 Aug 2002
   scancode oops                     closed                22 Aug 2002
   cciss broken                      proposed fix          14 Aug 2002
   qlogicisp oops                    open                  14 Aug 2002
   qlogic error                      open                  23 Aug 2002
   kmap_atomic oops                  open                  15 Aug 2002
   swap problem                      open                  20 Aug 2002
   oops in gpm.c                     open                  22 Aug 2002
   page allocation failure           open                  22 Aug 2002
   driverfs oops                     open                  25 Aug 2002



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSHBClz>; Thu, 1 Aug 2002 22:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSHBClz>; Thu, 1 Aug 2002 22:41:55 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:53211 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317893AbSHBCly>;
	Thu, 1 Aug 2002 22:41:54 -0400
Date: Thu, 1 Aug 2002 21:39:26 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Status report
Message-ID: <Pine.LNX.4.44.0208012031220.27455-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus has issued 2.5.30 so here is an updated status report.  The most 
current version is at 

http://members.cox.net/kernprobs/status.html

I've discovered I don't see everything (duh!) and I also may miss the 
significance of a message.  Several times I've been told a particular 
problem has been fixed by a bk patch which I've not seen.  Sure enough, 
someone either reports that the problem no longer manifests itself, or 
discussion ceases.  I can't document what I can't see, so if it isn't 
discussed, it won't be reported here.

The sigmask problem is being carried as open.  However, the latest series 
of messages has seemingly transitioned into a policy discussion.  

There doesn't appear to be agreement whether a generic ide problem exists.  
Even if one does exist, Linus has four patchsets (108-111) in 2.5.30, 
making it difficult to track individual problems.  I do have a couple 
in the current list, and there are specific comments on each.  I'll track 
those as best I can, but I'm not going to carry the "generic" ide 
discussion.


I hope this is proving useful.  Feedback is welcome.


            Kernel Problem Reports as of 01 Aug
   Problem Title                     Status       Discussion
   IDE problem                       closed       2.5.29
   RAID                              closed       2.5.28
   OOPS with date                    closed       2.5.28
   cpqarray broken since 2.5.19      closed       2.5.28
   schedule() with irqs disabled!    proposed fix 2.5.29
   ISDN broken?                      closed       2.5.28
   bonding driver failure in 2.5     open         2.5.29
   serial oops                       proposed fix 2.5.29
   NUMA-Q minimal workaround updates open         2.5.29
   PnP BIOS problem                  open         2.5.29
   New connections stall             open         2.5.29
   JFS oops                          open         2.5.29
   ide option problem                open         2.5.29
   ide cli/sti removal               open         2.5.29
   serial core on embedded PPC       open         2.5.29
   handle_scancode oops              open         2.5.29
   spinlock deadlock                 open         2.5.29
   smp cpu problem                   open         2.5.29
   sigmask problem                   open         2.5.29




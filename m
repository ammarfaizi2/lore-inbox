Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261247AbREZOfk>; Sat, 26 May 2001 10:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbREZOfa>; Sat, 26 May 2001 10:35:30 -0400
Received: from web12304.mail.yahoo.com ([216.136.173.102]:6674 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261247AbREZOfV>; Sat, 26 May 2001 10:35:21 -0400
Message-ID: <20010526124840.261.qmail@web12304.mail.yahoo.com>
Date: Sat, 26 May 2001 05:48:40 -0700 (PDT)
From: Mariam George <mariam_reeny@yahoo.com>
Subject: QOS &fair queuing modules- can't load
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   Let me put across my situation. I need to load the
modules for QOS & Fair Queuing . I have compiled my
kernel with modular support for these modules. When I
try to load these modules a series of error messages
all indicating unresolved symbols are coming. The
unresolved symbols  are all defined in
/usr/src/linux/include/net/pkt_sched.h. 
I have checked out /proc/ksyms file and these symbols
are listed there, 
(not the usual way). Here is an entry from the file
for one of the unresolved symbols. 
 c01558cc register_qdisc_R__ver_register_qdisc
Can anyone please help me figure out what the problem
is? 
Thanking You in advance,
          Mariam.
NB: Please reply to me personally as I am not
subscribed to this list.

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/

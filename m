Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTLWFGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 00:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTLWFGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 00:06:14 -0500
Received: from 6696205200.hostnoc.net ([66.96.205.200]:14354 "EHLO
	beorn.cosoftwareshop.com") by vger.kernel.org with ESMTP
	id S264480AbTLWFGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 00:06:13 -0500
From: "Don t Spam Me!!!" <junk@markschaefer.org>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0 and Compaq Proliant 6500 Pentium Pro
X-Mailer: NeoMail 1.26
X-IPAddress: 69.47.25.55
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1AYejy-0003ut-1z@beorn.cosoftwareshop.com>
Date: Mon, 22 Dec 2003 22:05:54 -0700
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - beorn.cosoftwareshop.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32005 506] / [47 12]
X-AntiAbuse: Sender Address Domain - beorn.cosoftwareshop.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

     I was successfully running the latest RedHat 9 kernel (2.4.20-smp) 
and upgraded to Fedora Core stable(2.4.22-nptlsmp) and testing
(2.6.0smp).  The 6500 has an Orion (82450KX) chipset.  During bootup, I 
receive a number of error messages.  Among other things:
1)   The system is a quad processor PPro, but it says "no smp detected"
2)   I get two ACPI errors (ACPI-0084 and ACPI-0134)
3)   The kernel cannot determine the bus topology, and kudzu asks me to 
reconfigure my two ethernet cards everytime I boot
4)   I was using two 3c905 cards, but now am using one 3c905 and one 
TLAN.  Apparently, these are both working.

     I'm sorry that the RedHat kernel isn't more standard because I'd 
be able to tell you exactly when the support broke.  There were a few 
of the older RH9 kernels that I couldn't run because they would hang at 
boot time, but the latest one was working wonderfully.

     Does anyone have any pointers (aside from tossing the computer in 
the garbage or downgrading to RedHat 9 again - although that's 
presently my only option)

     I _can_ get some more verbose descriptions if someone wants to 
point me in the right direction - I've been hacking with Linux since 
1994 so I'm not a newbie.

Thanks!

Mark Schaefer

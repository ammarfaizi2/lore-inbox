Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRFIRrI>; Sat, 9 Jun 2001 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264442AbRFIRqs>; Sat, 9 Jun 2001 13:46:48 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:34501 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S264432AbRFIRqq>; Sat, 9 Jun 2001 13:46:46 -0400
Date: Sat, 09 Jun 2001 12:45:10 -0500
From: "Glenn C. Hofmann" <hofmanng@swbell.net>
Subject: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
To: linux-kernel@vger.kernel.org
Reply-to: hofmang@ibm.net
Message-id: <3B221A56.31120.3C1910@localhost>
MIME-version: 1.0
X-Mailer: Pegasus Mail for Win32 (v3.12c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried 2.4.5-pre2 up to 2.4.6-pre1 with the same results.  Everything boots 
great and I can login fine.  When I try to assign an IP via DHCP or ifconfig, the system 
sits and stares at me indefinitely.  2.4.5-pre4 didn't compile for me, but pre3 works fine 
and pre5 locks.  There is keyboard response, and Alt-SysRq will tell me that it knows I 
want it to sync the disks, but won't actually do it.  It will reboot, though.  I can switch 
between terminals, but cannot type anything at the login prompt.

The board is a Abit KT7-RAID.  I have waited to see if this issue has been resolved and 
will recompile the newer kernels (AC and Linus flavours) to see if it has cleared up, but 
wanted to see if maybe there is something else I should look at.  I can provide any more 
information that might help, so please let me know.  Thanks in advance.


Glenn C. Hofmann

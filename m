Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRBBPye>; Fri, 2 Feb 2001 10:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129816AbRBBPyX>; Fri, 2 Feb 2001 10:54:23 -0500
Received: from cloudburst.umist.ac.uk ([130.88.119.66]:35602 "EHLO
	cloudburst.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S129790AbRBBPyM>; Fri, 2 Feb 2001 10:54:12 -0500
From: T.Stewart@student.umist.ac.uk
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Feb 2001 15:55:31 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: DFE-530TX with no mac address
Message-ID: <3A7AD873.821.F1A284@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I have a D-Link DFE-530TX Rev A, PCI ethernet card, but it refuses 
to work.

I have looked at http://www.scyld.com/network/index.html#pci 
which sugests using the via-rhine driver.

I did this and compiled it into the kernel. It detects it at boot (via-
rhine v1.08-LK1.1.6 8/9/2000 Donald Becker) but says the 
hardware address (mac address?) is 00-00-00-00-00-00.

The card is not a DF-530TX or a DFE-530TX+ AFAIK.

www.d-link.com don't do linux drivers or say anything about linux.

The card works perfect with d-link drivers in win98 and w2k.

Whats the differance between via-rhine in 2.2.18 and 2.4.1?

Can any one help?

Thanks for reading

tom
(can u cc replys to me)

Some more info:-
pci device 00:0a.0
io=0xD400
irq=9

linux-2.4.1
glibc-2.2.1
gcc-2.95.3

ps I have tryed to exaust all prosabilitys before posting here, and I 
am sorry if this is stupid, its my first post to linux-kernel!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbRGWPS7>; Mon, 23 Jul 2001 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268262AbRGWPSs>; Mon, 23 Jul 2001 11:18:48 -0400
Received: from datpx.datinfor.pt ([194.38.135.2]:55825 "EHLO datpx.datinfor.pt")
	by vger.kernel.org with ESMTP id <S268261AbRGWPSh> convert rfc822-to-8bit;
	Mon, 23 Jul 2001 11:18:37 -0400
Message-ID: <5D478FF55EA3D311ACBF00062938832FFE51@DATPT01>
From: Jaime Alexandre Bastos <JaimeAlex@DATINFOR.pt>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RedHat 7.1 - Network messages
Date: Mon, 23 Jul 2001 15:57:37 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hi guys
I have got a Pentium Celeron, 64Mb RAM, IDE Disk, 2 D-LINK FX-530 PCI
Network´s installed with Linux RedHat 7.1 working as a firewall.
I made a new kernel, and now I usually get some messages from the kernel
which repeats a lot of times while the system is working.
The messages are:

Jul 23 09:14:13 datdnn kernel: eth0: Oversized Ethernet frame spanned
multiple buffers, entry 0xe length 0 status 00000600!
Jul 23 09:14:13 datdnn kernel: eth0: Oversized Ethernet frame c37740e0 vs
c37740e0.
Jul 23 09:14:13 datdnn kernel: eth1: Oversized Ethernet frame spanned
multiple buffers, entry 0x2 length 0 status 00000600!
Jul 23 09:14:13 datdnn kernel: eth1: Oversized Ethernet frame c382c020 vs
c382c020.

Jul 23 11:10:24 datdnn kernel: NET: 9 messages suppressed.
Jul 23 11:10:24 datdnn kernel: NET: 13 messages suppressed.

Jul 19 11:17:09 datdnn kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 19 11:17:09 datdnn kernel: eth1: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:17:30 datdnn kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 19 11:17:30 datdnn kernel: eth0: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:17:34 datdnn kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 19 11:17:34 datdnn kernel: eth0: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:17:37 datdnn kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 19 11:17:37 datdnn kernel: eth1: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:17:40 datdnn kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 19 11:17:40 datdnn kernel: eth0: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:17:49 datdnn kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 19 11:17:49 datdnn kernel: eth1: Transmit timed out, status 0000, PHY
status 782d, resetting...
Jul 19 11:20:32 datdnn kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 19 11:20:32 datdnn kernel: eth0: Transmit timed out, status 0000, PHY
status 782d, resetting...

Please, I would like to know if this messages means everything bad in terms
of fine function of the system and if so, what I should do to resolve the
problem.
I have the idea that specially when the last messages appear the system lose
communication. 
Sometimes I have to power off the system to get it fine again.

Thanks for you possible help.

My best Regards

Jaime Alexandre
Datinfor - Informática Serviços e Estudos, Lda 
Tel.  351-226051700   Fax . 351-226051710
Address Mail.  JaimeAlex@datinfor.pt



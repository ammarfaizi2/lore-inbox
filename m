Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbRGYRj2>; Wed, 25 Jul 2001 13:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRGYRjS>; Wed, 25 Jul 2001 13:39:18 -0400
Received: from [64.76.58.171] ([64.76.58.171]:37261 "HELO sigma.cioh.org.co")
	by vger.kernel.org with SMTP id <S267188AbRGYRjM>;
	Wed, 25 Jul 2001 13:39:12 -0400
Date: Wed, 25 Jul 2001 12:38:55 -0500 (COT)
From: "TO. Wilderman Ceren" <wceren@sigma.cioh.org.co>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: problems with dmfe.o in 2.4.7 (fwd)
Message-ID: <Pine.LNX.4.33L2.0107251238260.7542-100000@sigma.cioh.org.co>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello linux.kernel deja newsgroup &  mailing list users!!.


I have a problem., i compile this morning the kernel 2.4.7, when i
reboot and load the new compiled bzImage, the module is not loaded by
insmod., errors found:

/lib/modules/2.4.7/kernel/drivers/net/dmfe.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod
/lib/modules/2.4.7/kernel/drivers/net/dmfe.o failed
/lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod dmfe failed

Help Me Please!!., i need load this module into my new kernel.
Need configure IPTABLES & NAT., i'm working with IPAliasing with a
Digital Tulip Ethernet compatible.

I'm trying test with the same tulip.o and in the ifconfig status., have
many errors in TX/RX and finally dead, suspend the traffic and the
interface (eth1) is lost.



Wilderman Ceren
CIOH - Armada Nacional Colombia


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131373AbRANLIJ>; Sun, 14 Jan 2001 06:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131833AbRANLH7>; Sun, 14 Jan 2001 06:07:59 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:51204 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131373AbRANLHx>; Sun, 14 Jan 2001 06:07:53 -0500
Date: Sun, 14 Jan 2001 12:07:36 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: SMP Problem with RTL8139
Message-ID: <Pine.LNX.4.31.0101141152400.2684-100000@phoenix.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I need help with the following problem on my
Dual Pentium III 550Mhz with kernel 2.2.17 SMP
and RTL8139 as eth0 :

Sometimes the message

 eth0: RTL8139 Interrupt line blocked, status 1.

appears which doesn't seem to cause problems, but
yesterday the message

 eth0: SMP simultanous entry of an interrupt handler.

appeared just after it. From this moment the
network performance goes down to just a few bytes per
second until system restart.

Is this a known problem ?

Thanks for any hint.

Armin





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

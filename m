Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbRCFXO3>; Tue, 6 Mar 2001 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRCFXOS>; Tue, 6 Mar 2001 18:14:18 -0500
Received: from mail2.svr.pol.co.uk ([195.92.193.210]:19784 "EHLO
	mail2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129663AbRCFXOM>; Tue, 6 Mar 2001 18:14:12 -0500
Date: Tue, 6 Mar 2001 23:16:02 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: ES1371 problem (2.4.2)
Message-ID: <Pine.LNX.4.33.0103062311450.9360-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Approx. 90% of the time my es1371 sound card refuses to work.
dmesg reveals:
es1371: version v0.27 time 16:38:48 Mar  3 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
PCI: Found IRQ 10 for device 00:0b.0
es1371: found es1371 rev 8 at io 0xa400 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

When it works (I'm not sure, but a clean boot helps) the id fields are
non-zero.

My setup:

Athlon/KX133 (VIA chipset)/Creative SB64 PCI
kernel 2.4.2/gcc 2.96 (latest)

I am using devfs also.

Please CC any replies to this address.



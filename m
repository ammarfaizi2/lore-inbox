Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135906AbRD3VJr>; Mon, 30 Apr 2001 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136522AbRD3VJh>; Mon, 30 Apr 2001 17:09:37 -0400
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:34112 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S135906AbRD3VJ0>; Mon, 30 Apr 2001 17:09:26 -0400
Date: Mon, 30 Apr 2001 22:12:21 +0100 (BST)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: AC97/es1371 detection problem
Message-ID: <Pine.LNX.4.33.0104302208340.3207-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux won't detect my AC97 (Cirrus Logic, er something I forget exactly)
soundcard from a cold start. Reset the machine and it loads up fine.

Ideas?

VIA KX133 motherboard BTW.

mtrr: 0xe0000000,0x2000000 overlaps existing 0xe0000000,0x1000000
es1371: version v0.30 time 14:11:05 Apr 28 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
PCI: Found IRQ 10 for device 00:0b.0
es1371: found es1371 rev 8 at io 0xa400 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)


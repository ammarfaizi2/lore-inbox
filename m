Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283206AbRK2MsI>; Thu, 29 Nov 2001 07:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283210AbRK2Mr6>; Thu, 29 Nov 2001 07:47:58 -0500
Received: from h217n3fls22o974.telia.com ([213.64.105.217]:45035 "EHLO
	milou.dyndns.org") by vger.kernel.org with ESMTP id <S283206AbRK2Mrv>;
	Thu, 29 Nov 2001 07:47:51 -0500
Message-Id: <200111291247.fATClEX23157@milou.dyndns.org>
To: "gw boynton" <audio@crystal.cirrus.com>, linux-kernel@vger.kernel.org
Subject: cs4281 dead after BIOS upgrade
From: Anders Eriksson <aer-list@mailandnews.com>
Date: Thu, 29 Nov 2001 13:47:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I just upgraded the BIOS on my Dell L400 laptop from rev A01 to A03. Now the cs4281 module refuses to load. I used to load perfectly.

Nov 29 13:19:40 devil kernel: cs4281: version v1.13.32 time 17:15:07 Nov 28 2001
Nov 29 13:19:40 devil kernel: PCI: Found IRQ 10 for device 00:08.0
Nov 29 13:19:41 devil kernel: cs4281: DLLRDY failed!
Nov 29 13:19:41 devil kernel: cs4281: cs4281_hw_init() failed. Skipping part.
Nov 29 13:19:41 devil kernel: cs4281: probe()- no device allocated

Any suggestions as to how to track down the offending changes?

/Anders

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRCMV51>; Tue, 13 Mar 2001 16:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRCMVcA>; Tue, 13 Mar 2001 16:32:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131194AbRCMVbF>;
	Tue, 13 Mar 2001 16:31:05 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Alert on LAN for Linux? 
MIME-Version: 1.0
Message-Id: <E14cvTq-0000oH-00@morgoth>
Date: Tue, 13 Mar 2001 21:33:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alert on LAN seems to have some useful functionality, if I understand
things correctly they have enhanced Wake-on-LAN to allow you to do
things like reset the machine, update the BIOS and such by sending
magic packets which are interpreted by the network card. Or maybe I am
reading too much into this:

http://www.pc.ibm.com/us/desktop/alertonlan/

Anyway, my eepro100 cards say they are Alert on LAN capable, it would
be very useful to be able to use this reboot a Linux box remotely:

02:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)

	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter with Alert On LAN*
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at 40200000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 1400 [size=64]
	Memory at 40100000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

Does anybody know anything about Alert on LAN and whether it does what
I think it does?

-- 
 - Terje
malmedal@usit.uio.no

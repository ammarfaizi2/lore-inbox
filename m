Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUCRKvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUCRKvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:51:45 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53195 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262511AbUCRKvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:51:43 -0500
Date: Thu, 18 Mar 2004 18:47:49 +0800
Subject: 2.6.x atkbd.c moaning
To: "kernel mailing list" <linux-kernel@vger.kernel.org>
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr41z9zel4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is this and should I investigate further?

Regards
Michael

mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.


00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS651 Host (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 25)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter

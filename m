Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbTLZVzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbTLZVzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 16:55:12 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:27784 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265245AbTLZVzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 16:55:08 -0500
Date: Fri, 26 Dec 2003 13:55:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0 sound output - wierd effects
Message-ID: <1080000.1072475704@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgraded my home desktop to 2.6.0. 
Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confirmed
this happens on mainline, as well as -mjb.

If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
I'll get some wierd effect for a few seconds, either static, or the track 
will mysteriously speed up or slow down. Then all is back to normal for 
another couple of minutes.

Anyone else seen this, or got any clues? Else I guess I'm stuck playing
bisection search.

Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
PCI: Found IRQ 11 for device 0000:00:02.7
intel8x0: clocking to 48000
ALSA device list:
#0: SiS SI7012 at 0xdc00, irq 11

AMD Athlon(tm) XP 2100+, no power management or ACPI compiled in.

M.


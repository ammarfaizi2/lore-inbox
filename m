Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUCGDAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 22:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUCGDAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 22:00:00 -0500
Received: from [65.39.167.249] ([65.39.167.249]:1237 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261743AbUCGC76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 21:59:58 -0500
Date: Sat, 6 Mar 2004 21:59:57 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: keyboard problems.. incorrect blame assigned
Message-ID: <Pine.LNX.4.58.0403062154490.6592@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is showing up before X is started and I'm pretty sure I'm not
loading kybdrate.  In fact, it's spewing this before even the init
scripts are loaded.

	Gerhard

input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05
15:41:49 2004 UTC).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
intel8x0_measure_ac97_clock: measured 44826 usecs
intel8x0: clocking to 48000


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

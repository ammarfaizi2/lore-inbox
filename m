Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSKNLrS>; Thu, 14 Nov 2002 06:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbSKNLrS>; Thu, 14 Nov 2002 06:47:18 -0500
Received: from posti2.jyu.fi ([130.234.4.33]:10894 "EHLO posti2.jyu.fi")
	by vger.kernel.org with ESMTP id <S264867AbSKNLrR>;
	Thu, 14 Nov 2002 06:47:17 -0500
Date: Thu, 14 Nov 2002 13:54:10 +0200 (EET)
From: Jani Averbach <jaa@cc.jyu.fi>
To: <linux-kernel@vger.kernel.org>
Subject: How do I re-activate IDE controller (secondary channel) after boot?
Message-ID: <Pine.GSO.4.33.0211141339170.12421-100000@tukki.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Is there any way to activate again secondary IDE channel from kernel (or
user space), if I has disabled it from bios?

My problem is that:
The bios won't boot at all if I have over 32G hard disk connected, but if
I disabled secondary IDE channel, it will.

So is it possible to re-activate this IDE channel, and if it is possible,
how this should be done and would this cause any trouble afterward?

At the moment my kernel version is 2.4.20-rc1.

My IDE controller is:

00:01.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at e000 [size=16]

Any advices are highly appreciate,

Jani

--
Jani Averbach


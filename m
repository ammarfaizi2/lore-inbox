Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUA0KgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUA0KgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:36:11 -0500
Received: from psyche.piasta.pl ([217.98.234.5]:62599 "EHLO psyche.piasta.pl")
	by vger.kernel.org with ESMTP id S263325AbUA0KgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:36:08 -0500
Subject: Re: Strange xmms deaths under high disk load
From: Piotr Kowalczyk <pikov@piasta.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: PRDKW (iols)
Message-Id: <1075199762.22166.14.camel@island.of.lost.souls.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 11:36:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World\n

> I have encountered a very strange (to me, at least) error.  I can
> reliably cause xmms to crash by simply doing some intensive disk IO.
> Copying a few hundred megabytes usually does it.  After about 20
> seconds of heavy disk IO, xmms will die with this message:

[...]

> Should I just call it an xmms bug, or should I start digging for
> hardware problems or kernel bugs?

Well, at least not hardware problems, I think. I don't know anything 
about messages that xmms throws, but it hangs regularly under heavy 
disk load. Usually clicking pause and play is enough to bring it back.
In case of doing anything else it hangs completely. 
I have Athlon XP 1700+, sound via via82xx, ATA-100, 
kernel 2.6.1 (with 2.6.0 was the same). 
Had no problems with 2.4, but haven't used alsa then. Maybe i'll try to
debug it a bit more if i find some time. 
chears, 

-- 
Piotr Kowalczyk <pikov@piasta.pl>
PRDKW (iols)


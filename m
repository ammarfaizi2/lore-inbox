Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbTIATM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTIATM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:12:57 -0400
Received: from mx2.mail.ru ([194.67.23.22]:5644 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263213AbTIATMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:12:54 -0400
Date: Mon, 1 Sep 2003 21:09:57 +0200 (CEST)
From: Guennadi Liakhovetski <lyakh@mail.ru>
Reply-To: Guennadi Liakhovetski <g.liakhovetski@web.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901155150.B22682@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309012107220.5752-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On

Processor       : Intel XScale-PXA250 rev 3 (v5l)
BogoMIPS        : 397.31
Features        : swp half thumb fastmult edsp
CPU implementor : 0x69
CPU architecture: 5TE
CPU variant     : 0x0
CPU part        : 0x290
CPU revision    : 3
Cache type      : undefined 5
Cache clean     : undefined 5
Cache lockdown  : undefined 5
Cache unified   : Harvard
I size          : 32768
I assoc         : 32
I line length   : 32
I sets          : 32
D size          : 32768
D assoc         : 32
D line length   : 32
D sets          : 32

and

Processor       : StrongARM-1100 rev 9 (v4l)
BogoMIPS        : 127.38
Features        : swp half 26bit fastmult

version 3 of the test consistently reports "Too slow".

Guennadi
---
Guennadi Liakhovetski




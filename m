Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbSL1SL1>; Sat, 28 Dec 2002 13:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbSL1SL1>; Sat, 28 Dec 2002 13:11:27 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:63237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266257AbSL1SL0>; Sat, 28 Dec 2002 13:11:26 -0500
Date: Sat, 28 Dec 2002 18:19:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Richard Henderson <rth@twiddle.net>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
In-Reply-To: <20021227155451.A3942@twiddle.net>
Message-ID: <Pine.LNX.4.44.0212281819070.5974-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Strange, it's defined in drivers/video/fbmem.c in my copy of 2.5.53.
> 
> Ah.  It's not exported, so fbcon as a module fails.
> Not sure how I missed it with a grep...

That problem is fixed already in the latest BK tree. I will push today the 
most recent fixes.


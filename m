Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTA3RyV>; Thu, 30 Jan 2003 12:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTA3RyV>; Thu, 30 Jan 2003 12:54:21 -0500
Received: from ip68-0-182-170.tc.ph.cox.net ([68.0.182.170]:48354 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267546AbTA3RyU>; Thu, 30 Jan 2003 12:54:20 -0500
Date: Thu, 30 Jan 2003 11:03:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, parisc-linux@parisc-linux.org,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Generic RTC driver in 2.4.x
Message-ID: <20030130180315.GA14768@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.GSO.4.21.0301051535430.10519-100000@vervain.sonytel.be> <Pine.GSO.4.21.0301102104190.18440-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301102104190.18440-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 09:05:55PM +0100, Geert Uytterhoeven wrote:
 
> Unfortunately I didn't receive any feedback from the pa-risc and ppc people
> after my previous posting last Sunday.
[snip]
> Pa-risc and ppc people (any other users?), please send me your enhancements (or
> just ack if none are necessary), so I can send genrtc to Marcelo.

Sorry I haven't spoken up before this, A simple cp of
include/asm-ppc/rtc.h (and then throwing the question
someplace) compiles a kernel correctly, and from what I recall of
getting it to work in 2.5, at that point it was all good anyhow.  So
this is fine for PPC32 as is.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

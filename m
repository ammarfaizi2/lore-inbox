Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266577AbRGJP3L>; Tue, 10 Jul 2001 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbRGJP3B>; Tue, 10 Jul 2001 11:29:01 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:57102 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S266583AbRGJP25>; Tue, 10 Jul 2001 11:28:57 -0400
Date: Tue, 10 Jul 2001 11:28:54 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: BIOS, Duron4 specifics...
Message-ID: <Pine.LNX.4.33.0107101121100.13575-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if this is a little offtopic but I'm stumped...

I've got a new laptop with an AMD Duron in it, based on the Athlon4 core
(PowerNow, SSE, hardware prefetch, etc.. Palomino core)..  However, it
appears none of the useful features are enabled in the bios.  For example,
Nowhere does it appear to enable SSE or the APIC.  Is there anyway I can
get at least UP-APIC working without BIOS help?  I really don't like
having 4 things on IRQ11... and how about SSE (fully realizing i'd have
to hack the kernel)?  It may or may not be worth it, but i'd like to play
with it just to see.

Also, whats the state of powernow/clock throttling support? I know there
was talk of a generic power management/clock control interface a while
back, where is that project/whats it's status/etc?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens



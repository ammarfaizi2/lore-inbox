Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSLQTdQ>; Tue, 17 Dec 2002 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSLQTdQ>; Tue, 17 Dec 2002 14:33:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31756 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266443AbSLQTdP>; Tue, 17 Dec 2002 14:33:15 -0500
Date: Tue, 17 Dec 2002 14:39:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel for Pentium 4 hyperthreading?
In-Reply-To: <20021215155819.GC20335@suse.de>
Message-ID: <Pine.LNX.3.96.1021217143514.20007D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002, Dave Jones wrote:

> On Sun, Dec 15, 2002 at 04:47:39PM +0100, Vergoz Michael (SYSDOOR) wrote:
>  > Hi,
>  > 
>  > It's possible to enable HT on any pentium 4, you just have to patch the bios
>  > :P
> 
> A rumour perpetuated by many, and achieved by none to my knowledge.

If W2k can tell if I enable HT or not, I assume it's really on.
Particularly if it then tells me I have more than two CPUs, my license
doesn't cover that, and it doesn't love me anymore.

Actually, 2.5.recent can get this right using APCI and will also work.
Guess the rumor is true, although I would say "many P4" rather than "all
P4" because I believe Intel disables one sibling at the bonding step
(based on information elsewhere) for some CPUs.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


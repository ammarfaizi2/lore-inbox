Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSAPRWG>; Wed, 16 Jan 2002 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAPRV7>; Wed, 16 Jan 2002 12:21:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6411 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284138AbSAPRUg>; Wed, 16 Jan 2002 12:20:36 -0500
Date: Wed, 16 Jan 2002 12:20:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KDE hang with 2.4.18-pre3-ac2
In-Reply-To: <16QsTK-0yvhtAC@fmrl10.sul.t-online.com>
Message-ID: <Pine.LNX.3.96.1020116121752.28369J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Hans-Christian Armingeon wrote:

> I've got the same problems with SuSE7.3 and kde2.2.2.
> With kernel 2.4.17, the X locks up, when I push the power button, the box tries to shut doen [I can hear a beep], but nothing else happens. After two or three sysrq keys specally sigterm to all processes, the system locks hard [reset cycle needed].
> I am trying 2.4.18-pre4 now.

Totally other problem. When my KDE won't launch tasks from the bar, it
will still work just fine otherwise, shutdown cleanly, etc. System is not
in any way hung, just that clicking the browser or terminal button doesn't
start a process, and if I bring up a menu from the bar, and try to start
something like moon phase, it also doesn't start.

I think the kernel told KDE something it didn't want to hear, so to speak.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


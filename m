Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSGFEYM>; Sat, 6 Jul 2002 00:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSGFEYL>; Sat, 6 Jul 2002 00:24:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5394 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317604AbSGFEYK>; Sat, 6 Jul 2002 00:24:10 -0400
Date: Sat, 6 Jul 2002 00:21:32 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
cc: george anzinger <george@mvista.com>, root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
In-Reply-To: <Pine.SOL.4.10.10207041109300.12365-100000@dogbert>
Message-ID: <Pine.LNX.3.96.1020706001934.12368B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Xinwen - Fu wrote:

>         In fact I want a timer (either in user level or kernel level).
> This timer (hope it is a periodic timer) must expire at the interval that
> I specify. For example, if I
> want that the timer expires at 10ms, it should never be fired at
> 10.0000000001ms or
> 9.9999999999ms. That is the key part that I want!

If you find a way to do picosecond latency on a PC let us know. I (a)
don't believe you need any such thing, and (b) think this is a troll. Or
is the femtosec? 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


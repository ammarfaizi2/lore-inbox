Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVGHUxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVGHUxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVGHUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:51:46 -0400
Received: from mail.tmr.com ([64.65.253.246]:38321 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262875AbVGHUtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:49:19 -0400
Message-ID: <42CEE833.7060200@tmr.com>
Date: Fri, 08 Jul 2005 16:55:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
References: <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu> <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain> <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707164831.GA25696@elte.hu>
In-Reply-To: <20050707164831.GA25696@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>It did the trick.  I got a network. But I also got a hell of a lot of 
>>'enqueued dead tasks'. But stupid me forgot to turn on capture in 
>>minicom, and haven't been able to reproduce the problem. I rebooted 
>>the machine which blew away all evidence of what occured, and it's now 
>>fine. I'll reboot a few more times to see if I can get it to break 
>>again.
> 
> 
> minicom has a scrollback feature (Alt-B), does that have the oops in 
> history perhaps? It can cache a couple of bootups typically.

Although the kermit protocol is not much used anymore, the kermit 
program is still a capable terminal interface, and includes logging. For 
those who don't like telnet or minicom, here's another program to dislike.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

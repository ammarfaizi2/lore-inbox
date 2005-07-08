Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVGHJyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVGHJyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVGHJyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:54:17 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:26838 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262406AbVGHJyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:54:11 -0400
Date: Fri, 8 Jul 2005 05:54:04 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <Pine.LNX.4.58.0507080242560.8133@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507080552030.8133@localhost.localdomain>
References: <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu>
 <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu>
 <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu>
 <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain>
 <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707164831.GA25696@elte.hu>
 <Pine.LNX.4.58.0507080242560.8133@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Jul 2005, Steven Rostedt wrote:

>
> To try and reproduce it again, I've added in /etc/rc3.d an S98reboot that
> will switch the system to runlevel 6 again, and repeat the process over
> and over. All this while connect to minicom and capturing.  Hopefully it
> will eventually show the same bug.  If not, maybe it was just a fluke.
>

OK, I just rebooted the machine a 100 times, and not one error.  Maybe it
was just because the system failed on an earlier boot?  I don't know, but
I can't spend any more time on it.  I'll keep my minicom's active at all
times now.

-- Steve


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbTCGU3R>; Fri, 7 Mar 2003 15:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbTCGU3Q>; Fri, 7 Mar 2003 15:29:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19931 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261776AbTCGU3Q>;
	Fri, 7 Mar 2003 15:29:16 -0500
Date: Fri, 7 Mar 2003 21:39:31 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <1047069277.752.45.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.44.0303072136590.22681-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Mar 2003, Martin Josefsson wrote:

> Some negative things:

if you have time/interest, could you re-test the negative things with X
reniced to -10, to further isolate the problem? Another thing to try is to
renice xmms to -10 (or RT priority). Which one makes the larger
difference?

	Ingo


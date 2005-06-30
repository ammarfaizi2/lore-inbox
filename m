Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVF3Swb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVF3Swb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVF3Swb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:52:31 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:13580 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262916AbVF3SwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:52:08 -0400
Date: Thu, 30 Jun 2005 11:59:13 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630185913.GA26707@nietzsche.lynx.com>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630015041.GA24234@nietzsche.lynx.com> <42C408ED.5030306@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C408ED.5030306@tmr.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:59:57AM -0400, Bill Davidsen wrote:
> The reasons you have to repeat yourself are (a) you lack communications 
> skills and expect people to read past your insults, (b) you're just 
> technically wrong in some cases, such as saying that the results would 
> be different if the kernel were compiled in an unrealistic way.

I'm going to stick to my original points that I've already discussed in
a number of earlier threads. SMP is needed for this patch to really
work. What was not understood by folks, still isn't, is that the
functionality of this system is more extensive than a simple dual kernel
set up. This is not a personality or communication skills issue. It's
folks not understand the patch out of ignorance and irrational fear, how
it really works, and what advantages it gives over dual kernels.

A lot of it is just flat out ignorance about RTOS in the Linux community.
They confuse theoretical and practical issues and assume that they are
right when they don't write RT apps, don't understand the patch or the
direction it's going.

This material has been covered over and over again in previous threads,
but a disconnected, persistent and hysterical group still FUDs this patch
continuously, which is why I'm losing patience with this. If you're coming
in middle of this story it can certainly seem that way, but the reverse is
true. If I have to insult folks as a preventative for negative rumors about
this patch, then so be it.

> Your point that SMP operation is important is true, but I see no reason 
> to think Ingo has missed that.

No negative comments were directed at Ingo of any sort. The nature of RTOS
changes as hardware advances. That's all I'm saying.

bill


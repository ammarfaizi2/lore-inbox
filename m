Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVFWBIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVFWBIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVFWBIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:08:39 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:4869 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261941AbVFWBIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:08:34 -0400
Date: Wed, 22 Jun 2005 18:15:10 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050623011510.GA3448@nietzsche.lynx.com>
References: <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com> <20050623005538.GA3348@nietzsche.lynx.com> <42BA0BCA.6020903@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA0BCA.6020903@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:09:30PM -0400, Karim Yaghmour wrote:
> But I don't want to "fight" Ingo. There would just be no point
> whatsoever with "fighting" with one the best developers Linux
> has. I started my involvement in these recent threads with a
> very clear statement that I was open to being shown wrong in
> having exclusively championed the nanokernel approach in the
> past. I set out to show myself wrong with these tests and
> beside some vague expectations, I truely didn't know what I
> was going to find. I certainly wouldn't have bet a hot-dog on
> preempt_rt coming neck-to-neck with the ipipe on interrupt
> latency ... So yes, in doing so some results I've found aren't

Yeah, but so what ? don't freak out and take all of this so seriously.
It's not like nanokernels are going to disappear when this patch gets
broader acceptance. And who cares if you're wrong ? you ? :) Really,
get a grip man. :)

And, of course, DUH, making a kernel fully preemptive makes it (near)
real time. These aren't unexpected results.

> that nice. But, hell, I didn't invent those results. They are
> there for anyone to repdroduce or contradict. I have no
> monopoly over LMbench, PC hardware, the Linux kernel, or
> anything else used to get those numbers.

Thanks for the numbers, really. I do expect some kind of performance
degradation, but there seems to be triggering some oddities with the
patch that aren't consistent with some of our expectations.

Be patient. :)

bill


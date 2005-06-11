Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVFKUOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVFKUOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVFKUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:14:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14494 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261806AbVFKUOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:14:12 -0400
Date: Sat, 11 Jun 2005 13:14:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611201422.GA1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42AA6A6B.5040907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA6A6B.5040907@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:36:59AM -0400, Kristian Benoit wrote:
> For the past few weeks, we've been conducting comparison tests between
> PREEMPT_RT and the Adeos nanokernel. As was clear from previous discussion,
> we've been open to be proven wrong regarding endorsement of either method.
> Hence, this comparison was done in order to better understand the impact
> of each method vis-a-vis vanilla Linux.

I took a quick look through, and am quite impressed.  I have not yet
had a chance to go through it carefully (much less read the read of
the thread), but wanted to say "thank you!!!" for doing the measurements.

I am sure that there will be some, umm, "controversy" over the benchmark
and measurement methodology, but getting some agreement on what to
measure and how to measure it will be very valuable.

My guess is that there will end up being more than one benchmark, given
the large variety of RT apps out there, but who knows?

						Thanx, Paul

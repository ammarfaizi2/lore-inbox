Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVFKOaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVFKOaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVFKOaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:30:11 -0400
Received: from opersys.com ([64.40.108.71]:13828 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261709AbVFKOaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:30:03 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Kristian Benoit <kbenoit@opersys.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       Karim Yaghmour <karim@opersys.com>, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <42AA9651.4050404@yahoo.com.au>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
	 <42AA9651.4050404@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 10:28:06 -0400
Message-Id: <1118500086.5786.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 17:44 +1000, Nick Piggin wrote:
> Ingo Molnar wrote:
> > could you send me the .config you used for the PREEMPT_RT tests? Also, 
> > you used -47-08, which was well prior the current round of performance 
> > improvements, so you might want to re-run with something like -48-06 or 
> > better.
> > 
> 
> The other thing that would be really interesting is to test latencies
> of various other kernel functionalities in the RT kernel (eg. message
> passing, maybe pipe or localhost read/write, signals, fork/clone/exit,
> mmap/munmap, faulting in shared memory, or whatever else is important
> to the RT crowd).

It is'nt be really hard to had different tests to the actual test set.
You'll be able to make your own tests soon.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVFKOZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVFKOZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFKOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:25:21 -0400
Received: from opersys.com ([64.40.108.71]:7172 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261707AbVFKOZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:25:16 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Kristian Benoit <kbenoit@opersys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, Karim Yaghmour <karim@opersys.com>,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <20050611103707.GA8799@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
	 <20050611103707.GA8799@elte.hu>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 10:23:20 -0400
Message-Id: <1118499800.5786.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 12:37 +0200, Ingo Molnar wrote:
> 
> > could you send me the .config you used for the PREEMPT_RT tests?
> Also, 
> > you used -47-08, which was well prior the current round of
> performance 
> > improvements, so you might want to re-run with something like
> -48-06 
> > or better.
> 
> make that -48-10 or better.

I get on that monday morning.

> one has to make sure the default debug options are disabled.  
> (DEADLOCK_DETECT, PREEMPT_DEBUG, etc.)

Can you tell me the exact list of option where talking about ?

Kristian


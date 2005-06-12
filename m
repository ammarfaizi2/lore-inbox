Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFLUgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFLUgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFLUgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 16:36:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32739 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261210AbVFLUgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 16:36:37 -0400
Date: Sun, 12 Jun 2005 13:36:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050612203659.GA1340@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42AA6A6B.5040907@opersys.com> <20050611201422.GA1299@us.ibm.com> <42AB66D1.20205@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB66D1.20205@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 06:33:53PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > My guess is that there will end up being more than one benchmark, given
> > the large variety of RT apps out there, but who knows?
> 
> I don't doubt. We just wanted to get people's attention to such aspects.
> We believe that the framework we've built is general enough that others
> will find it simple to graft their own tests on top and otherwise extend
> it to their needs.
> 
> In any case, having more serious benchmarks published will certainly do
> no harm.

Sounds good, agreed!

						Thanx, Paul

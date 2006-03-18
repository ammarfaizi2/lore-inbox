Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWCRI7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWCRI7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWCRI7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:59:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20423 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932331AbWCRI7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:59:49 -0500
Date: Sat, 18 Mar 2006 09:57:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.16-rc6-rt7
Message-ID: <20060318085725.GE23317@elte.hu>
References: <20060316095607.GA28571@elte.hu> <20060317233636.GB26253@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317233636.GB26253@smtp.west.cox.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:
> 
> > i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> I was wondering, is it normal for the nanosleep02 and alarm02 LTP 
> tests to fail?  For sometime I've seen these tests fail from time to 
> time with the -RT patch but not the regular kernel.

no, it's not normal. How repeatable is it?

	Ingo

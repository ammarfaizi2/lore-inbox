Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWITT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWITT5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWITT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:57:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55685 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932352AbWITT5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:57:48 -0400
Date: Wed, 20 Sep 2006 21:49:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920194958.GA24691@elte.hu>
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45118EEC.2080700@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4984]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > from the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> I got the following oops when trying to boot the above. Config is attached.

maybe it's not the right kernel image (2.6.17):

> EFLAGS: 00010297   (2.6.17-rt8 #4)

mixed with 2.6.18 modules?

	Ingo

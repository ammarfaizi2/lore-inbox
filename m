Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWIRO5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWIRO5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWIRO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:57:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60103 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751742AbWIRO5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:57:41 -0400
Date: Mon, 18 Sep 2006 16:48:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jes Sorensen <jes@sgi.com>
Cc: karim@opersys.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918144846.GA32122@elte.hu>
References: <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com> <450AB408.8020904@opersys.com> <450AB90C.9000403@sgi.com> <450AC2FA.70203@opersys.com> <450BD4C7.8030000@sgi.com> <450C1821.5010709@opersys.com> <450E5F6D.8070000@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E5F6D.8070000@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jes Sorensen <jes@sgi.com> wrote:

> >> tiny subset of the potential userbase for this stuff which is primarily
> >> useful to developers .... which in terms makes your argument about debug
> >> tracepoints irrelevant since you are turning all the tracepoints into
> >> debug tracepoints :)
> > 
> > How many embedded Linux projects did you personally work on?
> 
> You know what, I give up. Your primary interest seems to be in 
> attacking people personally because they didn't start out jumping up 
> and down clapping their hands in support of your pet project. [...]

i'm giving up on Karim too. I did apologize to Karim for the mistake i 
did in this thread-of-200-mails, but it's revolting to see that Karim 
still goes on and attacks top Linux contributors like you, without 
looking back, without apologizing for anything and without feeling any 
remorse. Karim patronized, attacked and insulted various people dozens 
of times in this thread alone. I just dont see any value in trying to 
"work with" Karim anymore, because it's apparently not something he is 
interested in doing. I feel a bit sorry for him too, because at heart he 
must be a deeply lonely person.

( I do see value in working with Mathieu, who has shown lot of insight, 
  patience, ability in cleaning up the LTT codebase and producing LTTng. 
  I dont envy him for having to work with Karim though. LTTng still 
  needs alot of work to be upstream-acceptable but my current impression 
  is that Mathieu's fundamentally professional approach will be 
  successful. )

> > How many embedded Linux projects did you personally work on?
> >
> [...] Even if I wanted to I couldn't tell you about the number of 
> different projects I have worked, partly because I can't remember half 
> of them, partly because of contract limitation, and most importantly 
> because I do not need to justify my experience to you.

you dont need to justify your experience to Karim. Your countless 
contributions to the Linux kernel speak for themselves. Most tellingly, 
his boasting aside, the only embedded-related Linux kernel contribution 
i have ever seen from Karim was the 1000-lines relayfs code - and even 
that code took years for Tom Zanussi to clean up and to get upstream. 
Besides that i have not seen a single line of code from Karim - not a 
single patch, not a oneliner fix, nothing. So if someone needs to prove 
his experience in embedded Linux matters on this forum then it's Karim.

	Ingo

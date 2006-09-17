Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWIQPeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWIQPeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWIQPeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:34:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33430 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964857AbWIQPeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:34:04 -0400
Date: Sun, 17 Sep 2006 17:25:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917152527.GC20225@elte.hu>
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171627400.6761@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Ingo, you happily still ignore my primary issues, how serious do you 
> expect me to take this?

I did not ignore your new "primary issues", to the contrary. Please read 
my replies. To recap, your "primary issues" are:

> The foremost issue is still that there is only limited kprobes 
> support.

> The main issue in supporting static tracers are the tracepoints and so 
> far I haven't seen any convincing proof that the maintainance overhead 
> of dynamic and static tracepoints has to be significantly different.

to both points i (and others) already replied in great detail - please 
follow up on them. (I can quote message-IDs if you cannot find them.)

[ Or if it's not these two then let me know if i missed some important 
  point - it's easy to miss a valid point in a sea of of replies. 
  For example yesterday i have replied to 7 different issues _you_ 
  raised, partly issues where you have questioned my credibility and 
  competence, so i felt compelled to reply - but still you replied to 
  none of those mails, only declaring them "secondary" in a passing 
  reference. If they were secondary then why did you raise them in the 
  first place? Or do you summarily concede all those points by not 
  replying to them? And is there any guarantee that you will reply to
  any mails i write to you now? Will you declare them "secondary" too 
  once the argument appears to turn unfavorable to your position? ]

	Ingo


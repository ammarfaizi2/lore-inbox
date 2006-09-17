Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWIQWnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWIQWnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 18:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWIQWnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 18:43:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10177 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965143AbWIQWnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 18:43:18 -0400
Date: Mon, 18 Sep 2006 00:34:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917223455.GC8791@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home> <20060917150953.GB20225@elte.hu> <Pine.LNX.4.64.0609171935070.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171935070.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4375]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Sun, 17 Sep 2006, Ingo Molnar wrote:
> 
> > Static tracers also need the 
> > guarantee of a _full set_ of static markups. It is that _guarantee_ of a 
> > full set that i'm arguing against primarily.
> 
> To those who are still reading this, let's fill this with a bit of 
> meaning (Ingo is unfortunately rather unspecific here):

Please make your own points instead of positing to "fill in" my points 
with "a bit of meaning". My words can certainly speak for themselves, 
and they do so in extensive specificity.

	Ingo

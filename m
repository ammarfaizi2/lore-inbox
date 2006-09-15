Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWIOVYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWIOVYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIOVYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:24:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14991 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932276AbWIOVYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:24:30 -0400
Date: Fri, 15 Sep 2006 23:15:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915211550.GB11291@elte.hu>
References: <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <450B1864.5060401@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B1864.5060401@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4990]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> [...] Consider, though, that I'm factually explaining the real-life 
> result of resistance to static instrumentation. [...]

with all due respect, do you realize the possibility that this 
resistance might be a genuine technical opinion on my part that is 
driven by the quality of the code being offered and by the conceptual 
problems static tracing introduces in the future, as i see them? And 
thus, maybe, what you wrote:

" and instead use their corporate bodyweight to pressure/seduce kernel
  developers working for them into pushing their new great [...] "

could possibly be total, utter nonsense?

	Ingo

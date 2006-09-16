Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWIPXWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWIPXWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIPXWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:22:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39348 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964840AbWIPXWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:22:43 -0400
Date: Sun, 17 Sep 2006 01:14:07 +0200
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
Message-ID: <20060916231407.GA23132@elte.hu>
References: <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609161831270.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4989]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> [...] instead of delving further into secondary issues, please let me 
> get back to the primary issues [...]

here's a list of some of those "secondary issues" that we were 
discussing, and which you opted not to "further dvelve into":

firstly, a factually wrong statement of yours:

> [...] any tracepoints have an maintainance overhead, which is barely 
> different between dynamic and static tracing [...]

secondly, a factually wrong statement of yours:

> [...] at the source level you can remove a static tracepoint as easily 
> as a dynamic tracepoint, [...]

thirdly, a factually wrong statement of yours:

> [...] It would also add virtually no maintainance overhead [...]

[see the previous mails for the full context on these items.]

	Ingo

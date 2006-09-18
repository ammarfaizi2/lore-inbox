Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWIRPZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWIRPZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIRPZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:25:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21376 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750930AbWIRPZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:25:15 -0400
Date: Mon, 18 Sep 2006 17:17:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918151713.GA11495@elte.hu>
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916173035.GA705@Krystal> <450E55BB.80208@sgi.com> <20060918145335.GD15605@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918145335.GD15605@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4899]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> You are late (I don't blame you about it, considering the size of this 
> thread). It has been posted in the following email :
> 
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg04492.html

yeah - and i dont think the kprobes overhead is a fundamental thing - i 
posted a few kprobes-speedup patches as a reply to your measurements.

	Ingo

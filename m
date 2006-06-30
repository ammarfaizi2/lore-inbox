Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWF3TGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWF3TGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWF3TGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:06:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14753 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964944AbWF3TGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:06:20 -0400
Date: Fri, 30 Jun 2006 21:01:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060630190128.GA31765@elte.hu>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com> <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain> <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com> <20060630185046.GB29566@elte.hu> <20060630190030.GB13429@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630190030.GB13429@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > thanks - i've applied this to -rt, we'll drop it once we rebase to 
> > 2.6.18-rc.
> 
> Why not apply the one already in mainline which _has_ been tested to 
> fix this issue!?!?!

sorry! I applied your patch and it's now in -rt5 that i just released.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966831AbWKUHTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966831AbWKUHTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934262AbWKUHTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:19:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11500 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934223AbWKUHTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:19:06 -0500
Date: Tue, 21 Nov 2006 08:17:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061121071741.GA20621@elte.hu>
References: <20061120220230.GA30835@elte.hu> <200611202239.29533.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611202239.29533.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0352]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> On Monday 20 November 2006 22:02, Ingo Molnar wrote:
> > i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the
> > usual place:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> Is there a git tree for -rt?

nope - and it's not really something that fits the git model that well. 
(it's frequently rebased)

	Ingo

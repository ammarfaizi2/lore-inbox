Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWFBLKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFBLKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWFBLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:10:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61389 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750717AbWFBLKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:10:41 -0400
Date: Fri, 2 Jun 2006 13:10:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602111053.GA22306@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <20060602120952.615cea39@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602120952.615cea39@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5043]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Ornati <ornati@fastwebnet.it> wrote:

> On Thu, 1 Jun 2006 01:48:06 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > - Various lock-validator and genirq fixes have been added.  Should be
> >   slightly less oopsy than 2.6.17-rc5-mm1.
> 
> Is it supposed to work on x86_64?

yeah, it's supposed to work.

> I've tried enabling something minimal (full config attached):

please send me the real full config you used for the build - this one 
has only the =y entries. (from which it's hard to reproduce your 
original config)

	Ingo

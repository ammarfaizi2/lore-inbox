Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936101AbWK1URT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936101AbWK1URT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936095AbWK1URT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:17:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54215 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936094AbWK1URS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:17:18 -0500
Date: Tue, 28 Nov 2006 21:15:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061128201549.GC26934@elte.hu>
References: <20061120220230.GA30835@elte.hu> <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com> <1164735207.1701.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164735207.1701.19.camel@mindpipe>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> >    I know there were some comments awhile back about being required 
> > to switch to PAM. Has that occurred?
> > 
> >    If not then there is a regression issue for realtime-lsm.
> 
> As Realtime LSM is an out of tree module and there's no stable kernel 
> module API it's impossible to prevent regressions.
> 
> That being said, the realtime LSM patch is so simple that it should 
> work - how exactly does it fail?

i can include it in -rt if it's simple enough - if someone's interested 
then please send me a patch.

	Ingo

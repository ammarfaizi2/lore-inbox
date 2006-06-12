Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752004AbWFLOVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbWFLOVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWFLOVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:21:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13954 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752004AbWFLOVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:21:21 -0400
Date: Mon, 12 Jun 2006 16:20:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-ID: <20060612142028.GA22154@elte.hu>
References: <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> <20060610100318.8900f849.akpm@osdl.org> <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com> <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com> <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com> <20060612110537.GA11358@elte.hu> <6bffcb0e0606120650l7116ac17vc3a0379194b56315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0606120650l7116ac17vc3a0379194b56315@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5005]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> I just tried your latest lockdep-combo-2.6.17-rc6-mm2 patch, and I get 
> many warnings
> 
> WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/sound/core/snd-pcm.ko
> needs unknown symbol down_write

ok, i have uploaded a new version - does that work any better?

	Ingo

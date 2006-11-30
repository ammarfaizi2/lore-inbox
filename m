Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758522AbWK3HVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbWK3HVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758529AbWK3HVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:21:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26834 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1758522AbWK3HVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:21:34 -0500
Date: Thu, 30 Nov 2006 08:19:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] 2.6.19-4c6-rt9 build problem
Message-ID: <20061130071923.GA14406@elte.hu>
References: <20061129194821.GA2895@us.ibm.com> <20061129200307.GA11591@elte.hu> <20061129224451.GC2335@us.ibm.com> <20061129231507.GG2335@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129231507.GG2335@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > > thanks, applied. Have you tried to boot the resulting kernel as 
> > > well?
> 
> And with these two changes, it does boot!

great! Applied both of them.

	Ingo

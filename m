Return-Path: <linux-kernel-owner+w=401wt.eu-S1751293AbXANO3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXANO3k (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbXANO3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:29:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52284 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbXANO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:29:39 -0500
Date: Sun, 14 Jan 2007 15:25:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2/3] Scheduled removal of SA_xxx interrupt flags fixups
Message-ID: <20070114142540.GA4807@elte.hu>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de> <20070114081926.967534281@inhelltoy.tec.linutronix.de> <20070114124252.GA4809@elte.hu> <1168784723.2941.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168784723.2941.65.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 2007-01-14 at 13:42 +0100, Ingo Molnar wrote:
> > i have tested your patch-queue ontop of rc4-mm1 (trivial reject fixups 
> > are below), it builds and boots fine.
> >
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> You tested my yesterday queue against rc2-mm1. The patches in the mail 
> are against rc4-mm1 and contain the fix already.

ok - great!

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946220AbWKJJd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946220AbWKJJd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946203AbWKJJd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:33:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19372 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946220AbWKJJd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:33:58 -0500
Date: Fri, 10 Nov 2006 10:33:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Mike Galbraith <efault@gmx.de>, Daniel Walker <dwalker@mvista.com>,
       Karsten Wiese <fzu@wemgehoertderstaat.de>, linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
Message-ID: <20061110093323.GA22053@elte.hu>
References: <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org> <1162742535.2750.23.camel@localhost.localdomain> <454E2FC1.4040700@rncbc.org> <1162797896.6126.5.camel@Homer.simpson.net> <20061106093815.GB14388@elte.hu> <1162807371.13579.4.camel@Homer.simpson.net> <20061106101117.GA20616@elte.hu> <1162808795.23683.2.camel@Homer.simpson.net> <26540.194.65.103.1.1163151084.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26540.194.65.103.1.1163151084.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> >> so the patch solves this problem for you?
> >
> > Yeah, seems to.  I'll let it run make check in a loop for a while to 
> > make sure the fatal oops stays gone too though.  If you don't hear 
> > from me, all is peachy (it will be methinks)
> 
> So far so good for this pester ;)

great - i've applied it and it should show up in the next code-drop.

	Ingo

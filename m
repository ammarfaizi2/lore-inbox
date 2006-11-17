Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933696AbWKQQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696AbWKQQSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933695AbWKQQSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:18:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10442 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933696AbWKQQSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:18:40 -0500
Date: Fri, 17 Nov 2006 17:17:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061117161742.GA10182@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163694712.26026.1.camel@localhost.localdomain> <Pine.LNX.4.64.0611162212110.21141@frodo.shire> <1163713469.26026.4.camel@localhost.localdomain> <20061116220733.GA17217@elte.hu> <1163779116.6953.38.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163779116.6953.38.camel@mindpipe>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2006-11-16 at 23:07 +0100, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > [...] Should we start a known regression list?
> > 
> > please resend the bugs that still trigger for you with 2.6.19-rt0.
> 
> I'm working with the developers of the 64Studio distro who are 
> attempting to ship a stable -rt kernel so I have access to lots of 
> good bug reports.  Oops on boot is by far the most common.  I'll post 
> details once we've retested with 2.6.19-rt0.

thanks, please do that. Right now i have no open boot-crash regression 
left that i can reproduce.

	Ingo

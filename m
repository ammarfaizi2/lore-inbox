Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWFVKCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWFVKCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWFVKCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:02:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38047 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161028AbWFVKCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:02:43 -0400
Date: Thu, 22 Jun 2006 11:56:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: bert hubert <bert.hubert@netherlabs.nl>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Daniel Jacobowitz <drow@false.org>, Alexandre Oliva <aoliva@redhat.com>
Subject: Re: [PATCH] utrace: new modular infrastructure for user debug/tracing
Message-ID: <20060622095618.GA1051@elte.hu>
References: <20060619105011.31953180049@magilla.sf.frob.com> <20060620073234.GA29317@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620073234.GA29317@outpost.ds9a.nl>
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


* bert hubert <bert.hubert@netherlabs.nl> wrote:

> On Mon, Jun 19, 2006 at 03:50:11AM -0700, Roland McGrath wrote:
> > I have been working on for a while, and imagining for much longer,
> > replacing ptrace from the ground up.  This is what I've come up with so
> > far, and I'm looking for some reactions on the direction.  What I'm
> 
> Roland,
> 
> Is this what has elsewhere been referred to as 'ptrace-ng'?

i think you must mean my mail on lkml calling it ptrace-ng, so yes.

	Ingo

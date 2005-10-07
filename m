Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVJGVQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVJGVQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVJGVQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:16:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19616 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932074AbVJGVQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:16:17 -0400
Date: Fri, 7 Oct 2005 23:16:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
Message-ID: <20051007211654.GA14996@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu> <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128714933.23974.3.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Fri, 2005-10-07 at 13:41 +0200, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > Maybe not related to rt10, but still can't build it, ".config" 
> > > attached:
> > 
> > ok, i fixed this in -rt11, does it build for you now?
> 
> rt12 bombs here on the smp/i686 compile (smp config attached):

ok - i have fixed these and have released -rt13 - does it work for you?

	Ingo

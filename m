Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUDNOoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbUDNOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:44:00 -0400
Received: from ns.suse.de ([195.135.220.2]:48770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263864AbUDNOn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:43:57 -0400
Date: Wed, 14 Apr 2004 16:41:35 +0200
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dvhltc@us.ibm.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
       mjbligh@us.ibm.com, ricklind@us.ibm.com, akpm@osdl.org
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
Message-Id: <20040414164135.75f1856f.ak@suse.de>
In-Reply-To: <407D473B.8010109@yahoo.com.au>
References: <1081466480.10774.0.camel@farah>
	<20040414154456.78893f3f.ak@suse.de>
	<407D473B.8010109@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004 00:14:19 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Andi Kleen wrote:
> > On Thu, 08 Apr 2004 16:22:09 -0700
> > Darren Hart <dvhltc@us.ibm.com> wrote:
> > 
> > 
> > 
> >>This patch is intended as a quick fix for the x86_64 problem, and
> > 
> > 
> > Ingo's latest tweaks seemed to already cure STREAM, but some more
> > tuning is probably a good idea agreed.
> > 
> 
> Where is STREAM versus other kernels? You said you got
> best performance on a custom 2.4 kernel. Do we match
> that?

Differences were below the measurement error, so I consider it fixed.

> 
> How is your performance for other things? I recall you
> may have told me about some other (smaller) issues you
> were seeing?

I haven't tested much yet.  I can compare kernel compilations later.

Also I'm still somewhat hoping that the IBM benchmark team will take a stab at 
it - they are much better than me at running many tests.

-Andi

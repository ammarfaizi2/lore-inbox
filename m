Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270220AbUJSXri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270220AbUJSXri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270182AbUJSXqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:46 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18051 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270166AbUJSXfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:35:00 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Lee Revell <rlrevell@joe-job.com>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <1098228272.12223.1134.camel@thomas>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
	 <32844.192.168.1.5.1098221406.squirrel@192.168.1.5>
	 <1098227713.23628.10.camel@krustophenia.net>
	 <1098228272.12223.1134.camel@thomas>
Content-Type: text/plain
Message-Id: <1098228897.23628.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 19:34:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 19:24, Thomas Gleixner wrote:
> On Wed, 2004-10-20 at 01:15, Lee Revell wrote:
> > On Tue, 2004-10-19 at 17:30, Rui Nuno Capela wrote:
> > > Ingo Molnar wrote:
> > > >
> > > > i have released the -U7 Real-Time Preemption patch:
> > > >
> > > >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
> > > >
> > 
> > Ingo, did you forget to cc: LKML on the U7 announcement, or is the list
> > just slow today?  I checked my mail as well as lkml.org, this does not
> > seem to have made it to the list.
> > 
> 
> Yes, it's slow. Postings drop in in random order with long delays.
> 

Sorry, I screwed up linux-kernel in the cc: list.

Lee


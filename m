Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269747AbUJWAct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbUJWAct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbUJWALE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:11:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41183 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269299AbUJWAKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:10:06 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041019195727.GA16453@nietzsche.lynx.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041019195727.GA16453@nietzsche.lynx.com>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 20:05:00 -0400
Message-Id: <1098489900.1440.35.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 12:57 -0700, Bill Huey wrote:
> On Tue, Oct 19, 2004 at 08:00:59PM +0200, Ingo Molnar wrote:
> > 
> > i have released the -U7 Real-Time Preemption patch:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
> 
> You should seriously think about using a kind of bitkeeper or CVS stle
> system so that multipule folks can dump stuff into it rapidly. This
> project is large enough that it needs some kind of facility like that.

We also might want to consider a separate mailing list, if the volume of
mail gets unwieldy, then just post release announcements to LKML.  The
volume is high enough and some of the terminology different enough that
we already had one inadvertent bout of flaming over some unfortunate
miscommunication.  As more people get involved this could get out of
hand.  The cc: lists are getting pretty long, and a lot of the testing
requires posting huge traces.  Think about how many copies of each mail
vger has to deliver...

Anyway, I am fine with continuing on LKML, it would really depend on how
Ingo and especially the people for whom this is all noise feel about it.

Lee 







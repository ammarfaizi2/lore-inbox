Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVFPFce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVFPFce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 01:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVFPFce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 01:32:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34503 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261742AbVFPFc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 01:32:29 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
In-Reply-To: <20050612092856.GB1206@infradead.org>
References: <1118214519.4759.17.camel@dhcp153.mvista.com>
	 <20050611165115.GA1012@infradead.org> <20050612062350.GB4554@elte.hu>
	 <20050612092856.GB1206@infradead.org>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 01:35:11 -0400
Message-Id: <1118900111.630.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 10:28 +0100, Christoph Hellwig wrote:
> On Sun, Jun 12, 2005 at 08:23:50AM +0200, Ingo Molnar wrote:
> > 
> > * Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > folks, can you please take this RT stuff of lkml?  And with that I
> > > don't mean the highlevel discussions what makes sense, but specific
> > > patches that aren't related to anything near mainline. [...]
> > 
> > this is a misconception - there's been a few dozen patches steadily 
> > trickling into mainline that were all started in the PREEMPT_RT 
> > patchset, so this "RT stuff", both the generic arguments and the details 
> > are very much relevant. I wouldnt be doing it if it wasnt relevant to 
> > the mainline kernel. The discussions are well concentrated into 2-3 
> > subjects so you can plonk those threads if you are not interested.
> 
> Then send patches when you think they're ready.  Everything directly
> related to PREEPT_RT except the highlevel discussion is defintly offotpic.
> Just create your preempt-rt mailinglist and get interested parties there,
> lkml is for _general_ kernel discussion - even most subsystems that are
> in mainline have their own lists.

I agree, this has to be annoying for people who have no interest in
PREEMPT_RT, and future PREEMPT_RT development is going to have zero
effect on people who don't enable it.

Any volunteers to set a list up?

Lee




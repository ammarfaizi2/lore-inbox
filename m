Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270913AbUJVJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270913AbUJVJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270909AbUJVJTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:19:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270907AbUJVJRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:17:48 -0400
Date: Fri, 22 Oct 2004 11:17:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022091714.GN1820@suse.de>
References: <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com> <20041022085928.GK1820@suse.de> <20041022090637.GA24523@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022090637.GA24523@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Bill Huey wrote:
> On Fri, Oct 22, 2004 at 10:59:28AM +0200, Jens Axboe wrote:
> > On Fri, Oct 22 2004, Bill Huey wrote:
> > > On Fri, Oct 22, 2004 at 08:19:01AM +0200, Jens Axboe wrote:
> > > > It has to go, why? Because your deadlock detection breaks? Doesn't seem
> > > > a very strong reason to me at all, sorry.
> > > 
> > > The deadlock detector is needed. Whether you understand that or not is
> > > irrelevant to the current work that's being done. And your idiot attacks
> > > against it doesn't correct these issues nor does it gain credibility
> > > with the audience that does find it useful.
> > 
> > *plonk*
> > 
> > If you can't stand criticism without resorting to feeble personal
> > attacks, I suggest you go elsewhere.
> 
> Then stick to the topic at hand, suggest positive changes, and cut the
> crap with implied personal attacks like the above. If you hadn't pull
> the discussion to that point, I wouldn't have reacted that way. It's
> completely juvenile behavior from you and you can't expect me or
> anybody else to take it sitting down.

What mails are you reading?!

Personally, I could not care less about the deadlock detection. If it's
a priority for you personally or due to corporate reasons, fine, but
don't involve me.

I have made no attacks on your deadlock detection other than to state
the obvious - that it has cases where it triggers on perfectly legit
code. If you read that as "implied personal attacks" or "juvenile
behaviour" then you need to grow thicker skin. The only personal attacks
here are the ones coming from you.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270909AbUJVJWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270909AbUJVJWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270907AbUJVJWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:22:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16032 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270930AbUJVJV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:21:29 -0400
Date: Fri, 22 Oct 2004 11:20:59 +0200
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
Message-ID: <20041022092058.GO1820@suse.de>
References: <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com> <20041022085928.GK1820@suse.de> <20041022090637.GA24523@nietzsche.lynx.com> <20041022090938.GB24523@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022090938.GB24523@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Bill Huey wrote:
> On Fri, Oct 22, 2004 at 02:06:37AM -0700, Bill Huey wrote:
> > On Fri, Oct 22, 2004 at 10:59:28AM +0200, Jens Axboe wrote:
> > > *plonk*
> > > 
> > > If you can't stand criticism without resorting to feeble personal
> > > attacks, I suggest you go elsewhere.
> > 
> > Then stick to the topic at hand, suggest positive changes, and cut the
> > crap with implied personal attacks like the above. If you hadn't pull
> > the discussion to that point, I wouldn't have reacted that way. It's
> > completely juvenile behavior from you and you can't expect me or
> > anybody else to take it sitting down.
> 
> This is also email, so misunderstanding and misinterpretations do
> happen. If that's the case, then I'm sorry to misunderstand you and then
> get upset, but next time be more specific about improving this code and
> other things related to it.

I've been as clear as I know how on the matter of semaphore use in
Linux. I've made no comments at all on improving your deadlock
detection scheme.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270903AbUJVJIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270903AbUJVJIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270885AbUJVJF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:05:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3225 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270873AbUJVJAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:00:00 -0400
Date: Fri, 22 Oct 2004 10:59:28 +0200
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
Message-ID: <20041022085928.GK1820@suse.de>
References: <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022085007.GA24444@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Bill Huey wrote:
> On Fri, Oct 22, 2004 at 08:19:01AM +0200, Jens Axboe wrote:
> > It has to go, why? Because your deadlock detection breaks? Doesn't seem
> > a very strong reason to me at all, sorry.
> 
> The deadlock detector is needed. Whether you understand that or not is
> irrelevant to the current work that's being done. And your idiot attacks
> against it doesn't correct these issues nor does it gain credibility
> with the audience that does find it useful.

*plonk*

If you can't stand criticism without resorting to feeble personal
attacks, I suggest you go elsewhere.

-- 
Jens Axboe


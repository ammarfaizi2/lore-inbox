Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270885AbUJVJI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270885AbUJVJI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270873AbUJVJGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:06:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29313 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270868AbUJVI7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:59:01 -0400
Date: Fri, 22 Oct 2004 11:00:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Jens Axboe <axboe@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022090006.GB16148@elte.hu>
References: <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022085007.GA24444@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> On Fri, Oct 22, 2004 at 08:19:01AM +0200, Jens Axboe wrote:
> > It has to go, why? Because your deadlock detection breaks? Doesn't seem
> > a very strong reason to me at all, sorry.
> 
> The deadlock detector is needed. Whether you understand that or not is
> irrelevant to the current work that's being done. And your idiot
> attacks against it doesn't correct these issues nor does it gain
> credibility with the audience that does find it useful.

oh no!

/me watches the flames fan out again as a bushfire

do you expect there to be any meaningful technical discussion resulting
out of you calling Jens' (valid) comments 'idiot attacks'? Fact is,
upstream couldnt care less about PREEMPT_REALTIME and/or the deadlock
detector at this point. Upstream _never_ cared about any not yet merged
(and in this case, completely unfinished) feature.

/me apologizes to Jens

	Ingo

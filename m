Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270032AbUJTLvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbUJTLvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270055AbUJTLtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:49:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4302 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270029AbUJTLph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:45:37 -0400
Date: Wed, 20 Oct 2004 13:43:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020114312.GA5418@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041020100424.GA32396@elte.hu> <11742.195.245.190.93.1098268363.squirrel@195.245.190.93> <20041020104005.GA1813@elte.hu> <15773.195.245.190.94.1098271919.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15773.195.245.190.94.1098271919.squirrel@195.245.190.94>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> > please re-download -U8, i've updated it a couple of minutes after
> > uploading it, but apparently not fast enough :-| Sorry!
> >
> 
> OK. No problem.... and yes, mkinitrd (make install) works again.

good.

> >> RTNL: assertion failed at net/ipv4/devinet.c (1049)
> >
> > yeah - this too was an oversight i fixed in the latest upload.
> 
> I don't think so. I still see plenty of those here.
> 
> Is there an even more recent U8? I think you should consider add some
> dot numbering to each of the uploads... ;)

indeed this most likely means there's a newer update :-| Please 
double-check that the one you have is:

 $ md5sum realtime-preempt-2.6.9-rc4-mm1-U8
 b59ae00ca0f45f545519348113af5c4f  realtime-preempt-2.6.9-rc4-mm1-U8

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUJHHFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUJHHFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJHHFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:05:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46552 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267415AbUJHHFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 03:05:32 -0400
Date: Fri, 8 Oct 2004 09:06:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041008070654.GA30926@elte.hu>
References: <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <56697.195.245.190.93.1097157219.squirrel@195.245.190.93> <32798.192.168.1.5.1097191570.squirrel@192.168.1.5> <1097213813.1442.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097213813.1442.2.camel@krustophenia.net>
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

* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2004-10-07 at 19:26, Rui Nuno Capela wrote:
> > Ingo Molnar wrote:
> > >
> > >>
> > >> i've released the -T3 VP patch:
> > >>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> > >>
> > >
> > 
> > OK. Just to let you know, both of my personal machines are now running on
> > bleeding-edge 2.6.9-rc3-mm3-T3, and very happily may I assure :)
> 
> This actually feels a _lot_ snappier than mm2, which seemed prone to
> weird stalls.  I don't have any numbers to back this up yet.

yeah, -mm is back to the development branch of the stock scheduler. 
(i.e. the scheduler changes destined for 2.6.10.)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUJELBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUJELBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268978AbUJELBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:01:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37332 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268972AbUJELBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:01:41 -0400
Date: Tue, 5 Oct 2004 13:03:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T0
Message-ID: <20041005110316.GA19964@elte.hu>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com> <20041005131237.63378c53@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005131237.63378c53@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Tue, 5 Oct 2004 03:02:05 -0400 (EDT)
> Ingo Molnar <mingo@redhat.com> wrote:
> 
> > i've released the -T0 VP patch:
> 
> >  - fix !4K stack compilation breakage (reported by Lee Revell)
> 
> I still need to enable 4k stacks to get it to build [see error below w/o 4k
> stacks].

doh - chunk went MIA. Updated the patch, please re-download -T0.

	Ingo

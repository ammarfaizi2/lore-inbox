Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVDASd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVDASd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVDASdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:33:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57730 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262844AbVDASaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:30:46 -0500
Date: Fri, 1 Apr 2005 20:29:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050401182955.GA12379@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <200504011231.55717.gene.heskett@verizon.net> <424D927F.2020601@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424D927F.2020601@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> >This one didn't go in cleanly Ingo.  From my build-src scripts output:
> >-------------------
> >Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04

> Adding the attached patch on top of the above should resolve the 
> failures, at least in the patching. Still working on building it.

i fixed these things up in -43-05 ... i hope :-|

	Ingo

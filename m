Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUGJH5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUGJH5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 03:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUGJH5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 03:57:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34185 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265878AbUGJH5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 03:57:21 -0400
Date: Sat, 10 Jul 2004 09:57:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710075747.GA25052@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709235017.GP20947@dualathlon.random>
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


* Andrea Arcangeli <andrea@suse.de> wrote:

> the other bad thing is that there is no  point for the sysctl [...]

 [snipped another 30 lines of rant]

> >  (Note to kernel patch reviewers: the split voluntary_resched type of
> >  APIs, the feature #ifdefs and runtime flags are temporary and were
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  only introduced to enable easy benchmarking/comparisons. I'll split
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  this up into small pieces once there's testing feedback and actual
> >  audio users had their say!)

	Ingo


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271431AbUJVQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271431AbUJVQuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271432AbUJVQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:50:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44487 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S271431AbUJVQuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:50:01 -0400
Date: Fri, 22 Oct 2004 18:51:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10
Message-ID: <20041022165113.GA26097@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <200410221247.58755.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410221247.58755.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> As sort of the ultimate dummy test, I'm building this right now.  The
> only oddments so far are a bunch of deprecated variable warnings,
> quite a few but many are dups.

these warnings are present in -mm1 too.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUJaMsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUJaMsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUJaMsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:48:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63175 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261613AbUJaMr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:47:29 -0500
Date: Sun, 31 Oct 2004 13:48:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031124828.GA22008@elte.hu>
References: <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de> <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031120721.GA19450@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> ok, could you try the -RT-V0.6.0 patch i've just uploaded? It could i
> believe improve these latencies.

hm, CONFIG_PARPORT_1284 seems broken, and USB too, it locks up during
bootup. Investigating ...

	Ingo

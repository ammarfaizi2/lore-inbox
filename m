Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUJaMyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUJaMyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUJaMyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:54:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64681 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261611AbUJaMyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:54:31 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041031124828.GA22008@elte.hu>
References: <1099158570.1972.5.camel@krustophenia.net>
	 <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de>
	 <1099165925.1972.22.camel@krustophenia.net>
	 <20041030221548.5e82fad5@mango.fruits.de>
	 <1099167996.1434.4.camel@krustophenia.net>
	 <20041030231358.6f1eeeac@mango.fruits.de>
	 <1099171567.1424.9.camel@krustophenia.net>
	 <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
Content-Type: text/plain
Date: Sun, 31 Oct 2004 07:54:29 -0500
Message-Id: <1099227269.1459.45.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 13:48 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > ok, could you try the -RT-V0.6.0 patch i've just uploaded? It could i
> > believe improve these latencies.
> 
> hm, CONFIG_PARPORT_1284 seems broken, and USB too, it locks up during
> bootup. Investigating ...
> 

FWIW with V0.5.16 I had several hard lockups when running Florian's test
app at 2048 Hz.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263339AbUJ2OiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbUJ2OiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbUJ2OfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:35:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16036 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263341AbUJ2O0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:26:37 -0400
Date: Fri, 29 Oct 2004 16:27:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029142747.GD25204@elte.hu>
References: <20041029134820.GA21746@elte.hu> <200410291419.i9TEJD75006459@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291419.i9TEJD75006459@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> for our purposes, the number of channels is irrelevant. the audio
> interface interrupts when it has and/or needs data. whether that data
> covers 2, 9, 26 or 128 channels isn't particularly important. each
> channel is handled at the same time. for most stereo devices, the data
> for the channels is actually interleaved; for some high end
> multichannel devices, each channel uses a separate memory buffer.
> either way, its really not central.

ok, thanks for the explanations.

	Ingo

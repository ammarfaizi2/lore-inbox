Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUHaS41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUHaS41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268788AbUHaS4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:56:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34765 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268776AbUHaSzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:55:40 -0400
Date: Tue, 31 Aug 2004 20:56:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831185656.GA27854@elte.hu>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com> <1093972819.5403.8.camel@krustophenia.net> <1093975773.5403.21.camel@krustophenia.net> <s5hk6vfywab.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk6vfywab.wl@alsa2.suse.de>
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


* Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 31 Aug 2004 14:09:33 -0400,
> Lee Revell wrote:
> > 
> > On Tue, 2004-08-31 at 13:20, Lee Revell wrote:
> > > Hmm, looks like the es1371 takes ~0.5 ms to set the DAC rate.  The ALSA
> > > team would probably be able to help.  Takashi, any ideas?
> > 
> > Ugh.  Please remove alsa-devel from any followups, as they seem to have
> > inadvertently enabled moderation.
> 
> IIRC, recently the moderation was disabled, so this should be no
> longer problem.

FYI, i still got 'your mail awaits moderation' messages just 2 minutes
ago.

	Ingo

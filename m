Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbUKVSFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUKVSFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKVSDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:03:25 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48355 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262273AbUKVSCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:02:38 -0500
Subject: Re: [Alsa-devel] Re: [2.6 patch] ALSA PCI drivers: misc cleanups
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <s5hoehpvkdl.wl@alsa2.suse.de>
References: <20041121235855.GI13254@stusta.de>
	 <1101088632.5119.2.camel@krustophenia.net> <s5hsm71vlrc.wl@alsa2.suse.de>
	 <1101145386.2873.2.camel@krustophenia.net>  <s5hoehpvkdl.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 13:02:36 -0500
Message-Id: <1101146556.2873.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 18:55 +0100, Takashi Iwai wrote:
> At Mon, 22 Nov 2004 12:43:05 -0500,
> Lee Revell wrote:
> > 
> > On Mon, 2004-11-22 at 18:25 +0100, Takashi Iwai wrote:
> > > At Sun, 21 Nov 2004 20:57:12 -0500,
> > > Lee Revell wrote:
> > > > 
> > > > On Mon, 2004-11-22 at 00:58 +0100, Adrian Bunk wrote:
> > > > >   - emu10k1/io.c: snd_emu10k1_voice_set_loop_stop
> > > > 
> > > > Please do not remove this function.  I am working on an enhancement to
> > > > the emu10k1 driver that uses it.
> > > 
> > > Do you need snd_emu10k1_sum_vol_attn, too?
> > > 
> > 
> > Nope.  Any idea what this is/was for?  I poked around the OSS driver and
> > could not find a similar function.
> 
> IIRC, it came from the very old version of OSS emu10k1 driver.
> 

OK.  I have added James to the cc.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTBPM0v>; Sun, 16 Feb 2003 07:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbTBPM0v>; Sun, 16 Feb 2003 07:26:51 -0500
Received: from gate.perex.cz ([194.212.165.105]:28432 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266540AbTBPM0u>;
	Sun, 16 Feb 2003 07:26:50 -0500
Date: Sun, 16 Feb 2003 13:36:49 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA broken in 2.5.61
In-Reply-To: <1045347495.682.10.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.44.0302161336150.1060-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Feb 2003, Martin Josefsson wrote:

> Hi,
> 
> I'm trying to use ALSA with my old sb16 in 2.5.61 and it sounds like
> hell :) worked fine in 2.5.58.
> 
> When trying to use OSS emulation it almost sounds like playing a c64
> tape at half speed and the mp3player chews through the song in a few
> seconds and I hardly see any interrupts beeing generated for the sb16 in
> /proc/interrupts. I see about 1 irq per 2 seconds.
> 
> When using native ALSA for playback it sounds almost ok but it's very
> choppy, sounds like it skips ahead 0.5-1 seconds every 2 seconds or so.
> Forgot to check the interruptrate when trying this.

We know about this problem and it will be fixed in next ALSA update.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


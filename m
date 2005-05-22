Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVEVN74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEVN74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 09:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEVN74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 09:59:56 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:9350 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261806AbVEVN7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 09:59:53 -0400
From: Christian Parpart <trapni@gentoo.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: snd-intel8x0 buggy on Nvidia CK804, TYAN, AMD Opteron board?
Date: Sun, 22 May 2005 15:59:51 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200505200938.17065.trapni@gentoo.org> <s5hpsvmp940.wl@alsa2.suse.de>
In-Reply-To: <s5hpsvmp940.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505221559.51729.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 20. May 2005 10:58, Takashi Iwai wrote:
> At Fri, 20 May 2005 09:38:15 +0200,
>
> Christian Parpart wrote:
> > Hi all,
> >
> > well, I'm just trying to listen to my music, however, it's either a no-go
> > (using ALSA-OSS emulation) or just a plain pain to listen to (via ALSA
> > directly).
> >
> > In first case, I just hear nothing. A `dd if=/dev/urandom of=/dev/dsp`
> > stops at a certain byte and in my headset I hear a very high beep tone.
> >
> > in second case, the music seems very deformed and the output is very
> > buggy at all (meaning, that it played just for a few minutes).
> > deformed means, that the foreground singer has been somewhat in the very
> > background and it overall has been very unfunny to listen to.
> >
> > I was trying different players and versions anyway.
> >
> > So, is this supposed to be a bug in the kernel sound driver for my
> > certain hardware?
>
> Do you run cpufreq or something related with that?

Nope, sorry, I even didnt install any of these cpufreq-alike tools on my host:
AMD Opteron on a TYAN board with nForce4 chipset.

Regards,
Christian Parpart.

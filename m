Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWBVNwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBVNwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWBVNwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:52:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14354 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932075AbWBVNwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:52:37 -0500
Date: Sun, 19 Feb 2006 19:19:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060219191907.GA2355@ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have SB Live! here. I remember it worked long time ago. Now I can't
> > get it to produce any sound :-(.
> >
> > root@hobit:~# cat /proc/asound/cards
> >  0 [Live           ]: EMU10K1 - SBLive! Value [CT4830]
> >                       SBLive! Value [CT4830] (rev.7,
> > serial:0x80261102) at 0x3000, irq 20
> >  1 [Bt878          ]: Bt87x - Brooktree Bt878
> >                       Brooktree Bt878 at 0xd0001000, irq 17
> >
> > root@hobit:~# uname -a
> > Linux hobit 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 23:53:41 CET 2006
> > i686 GNU/Linux
> >
> 
> I've got an SB Live! card here as well. Not exactely the same as yours
> (mine's rev. 10, yours is rev. 7), but mine works just fine with
> 2.6.16-rc4, so whatever is wrong it does not seem to effect all SB
> Live! cards...

Strange... My sb live! did not work with linux: all seemed okay,
but no sound, oss or alsa. My brother moved it on windows PC,
and got same failure, then bluescreens on next boots. He reseated the
card, and it started working. I guess it is flakey hw...

-- 
Thanks, Sharp!

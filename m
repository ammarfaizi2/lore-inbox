Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268564AbTGTVkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbTGTVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:40:05 -0400
Received: from mail.tlink.de ([217.9.16.16]:23823 "EHLO chewie.terralink.de")
	by vger.kernel.org with ESMTP id S268564AbTGTVj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:39:59 -0400
Subject: Re: 2.6.0-test1-mm2 music skips
From: Lukas Kolbe <lucky@knup.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F1B05D7.8060303@wmich.edu>
References: <1058733270.1169.32.camel@tigris.chaoswg>
	 <3F1B05D7.8060303@wmich.edu>
Content-Type: text/plain
Message-Id: <1058738207.17387.14.camel@tigris.chaoswg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 23:56:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Son, 2003-07-20 um 23.12 schrieb Ed Sweetman:
> Too many times music skipping is blamed on the kernel.  This is not 
> always the case.  Bad userspace programming can cause audio skipping. 
[...]

I didn't want to 'blame the kernel' for the audio-skipping, I just
followed Andrew Morton's call for feedback. One of three things I find
annoying in 2.5/2.6 is the audio-skipping, as far as I remember it 'felt
better' with the late 2.2 to middle 2.4 kernels on older hardware.

But I also have to say that interactivity (with heavy multitasking, many
apps, massive window-moving etc. pp) on my desktop-system has improved
very very much compared to 2.4. Though I don't have figures to back that
:).


> I'm not saying xmms is entirely at fault for the skips. But i've written 
> other ogg decoders for zinf that skipped as well doing those things. 
> Also, i moved to fluxbox as my window manager because other equally 
> functional window managers caused major X lag during redraws, fluxbox 
> does not.  Also, make sure you have dma enabled on your hdds, swap on a 
> non-dma drive can easily crawl the system.  And by the way, my x is 

Yay, hd's have dma enabled (udma5). And Metacity is indeed a problem, it
is damn lagging behind most other window managers, but it's gnome2's
default. 

> In short, it's not always the kernel that's the problem, but in the 
> implimentation the program uses for playing and  decoding audio. They 
> may need to be redone since what they used to be able to get away with 
> in older kernels doesn't work anymore now that it's more strict and fair 
>    and thus better at doing it's job.

ACK.

-- 
bye
  Lukas


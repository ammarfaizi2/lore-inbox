Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUASSYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUASSYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:24:06 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14512 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262540AbUASSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:23:57 -0500
Date: Mon, 19 Jan 2004 11:21:26 -0700
From: Travis Morgan <lkml@bigfiber.net>
Subject: Re: ALSA vs. OSS
In-reply-to: <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <1074536486.5955.412.camel@castle.bigfiber.net>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
References: <1074532714.16759.4.camel@midux>
 <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far I sort of tend to agree with you on OSS being better.

I have a soundblaster Live Value card. I can no longer control the
output level through my digital out. With OSS my PCM volume used to
affect both the headphone jack and the digital out. With ALSA it affects
only the headphone jack.

I have loaded up alsamixer and played with every level in there and it
doesn't seem possible to adjust the level anymore unless I adjust the
wave volume. As a result I've been unable to get xmms or gkrellm to
adjust the volume coming out of my stereo.

Now I like the idea of seperate volume controls, but this doesn't do
that.

Regards,
Travis M


On Mon, 2004-01-19 at 10:48, Steve Youngs wrote:
> * Markus Hästbacka <midian@ihme.org> writes:
> 
>   > but ALSA didn't let me to open two sound sources (like XMMS and
>   > Quake3) at the same time, so I guess it is not really done yet, or
>   > is it?
> 
> Works for me.  Right now I've got 3 instances of mpg123 playing 3
> different MP3s and XEmacs playing a big .wav file and an audio CD
> playing.  It's a horrible jumbled mess of noise coming out of my
> speakers, but it is working.


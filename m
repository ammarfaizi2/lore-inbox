Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUBYW2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUBYWZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:25:38 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:11149 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S261654AbUBYWVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:21:49 -0500
Subject: Re: ALSA vs. OSS
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hsmia7kdv.wl@alsa2.suse.de>
References: <s5hy8s27kz0.wl@alsa2.suse.de>
	 <Pine.LNX.4.44.0401201635140.20268-100000@midi>
	 <s5hsmia7kdv.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1077747703.12243.8.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 00:21:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 16:41, Takashi Iwai wrote:
> Hi,
> 
> there was a typo:
> 
> > > as a workaround, try to add the following to /etc/modprobe.conf:
> > >
> > > 	alias snd-pcm-oss nonblock_open=1
>         ^^^^^
>         options
Hi,

I tried this, but the problem still occurs.
Ok, here's a explanation of what I did:
1. I started xmms and started playing something (NOTE!!!: This doesn't
seem to matter at all, because I just tried without it and 3. still
hangs.)
2. I started TeamSpeak2
3. I started Quake3, Quake3 hangs.

So where could the problem occur?

There's no messages anywhere, no error messages anywhere.

I wonder if it matters if ALSA with it's oss things are compiled in?
(Not as module?)

        Markus


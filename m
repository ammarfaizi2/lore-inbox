Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293230AbSCBRpR>; Sat, 2 Mar 2002 12:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293260AbSCBRpH>; Sat, 2 Mar 2002 12:45:07 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:36231 "EHLO
	sparsus.humilis.net") by vger.kernel.org with ESMTP
	id <S293230AbSCBRox>; Sat, 2 Mar 2002 12:44:53 -0500
Date: Sat, 2 Mar 2002 18:44:50 +0100
From: Ookhoi <ookhoi@humilis.net>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        John Weber <john.weber@linuxhq.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.6-pre2 and ALSA Sound
Message-ID: <20020302184450.W8078@humilis>
Reply-To: ookhoi@humilis.net
In-Reply-To: <3C7F321B.2040603@linuxhq.com> <20020301164724.GB31210@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020301164724.GB31210@come.alcove-fr>
User-Agent: Mutt/1.3.19i
X-Uptime: 21:26:11 up 6 days,  4:16, 15 users,  load average: 0.07, 0.09, 0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> On Fri, Mar 01, 2002 at 02:47:39AM -0500, John Weber wrote:
> 
> > Anyone else having trouble with ALSA YMFPCI?  Everything compiles,
> > but I can't hear a thing (even with OSS compatibility enabled).
> 
> It does work for me at least, on a VAIO C1VE, kernel 2.5.6-pre2.

Can you also record sound via the microphone?


> lspci:
> 	00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
> 
> .config:
> 	CONFIG_SND=m
> 	CONFIG_SND_SEQUENCER=m
> 	CONFIG_SND_OSSEMUL=y
> 	CONFIG_SND_MIXER_OSS=m
> 	CONFIG_SND_PCM_OSS=m
> 	CONFIG_SND_SEQUENCER_OSS=m

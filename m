Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSB0Bev>; Tue, 26 Feb 2002 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291281AbSB0Bel>; Tue, 26 Feb 2002 20:34:41 -0500
Received: from f81.law15.hotmail.com ([64.4.23.81]:4366 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291247AbSB0Bea>;
	Tue, 26 Feb 2002 20:34:30 -0500
X-Originating-IP: [80.225.70.52]
From: "Jason Algol" <fooooobar@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810_audio support
Date: Wed, 27 Feb 2002 01:34:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F81aZ1i6bdVJWrGW6Ex000104ec@hotmail.com>
X-OriginalArrivalTime: 27 Feb 2002 01:34:25.0123 (UTC) FILETIME=[E39D6B30:01C1BF2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: fooooobar@hotmail.com (Jason Algol)
>CC: linux-kernel@vger.kernel.org
>Subject: Re: i810_audio support
>Date: Tue, 26 Feb 2002 22:58:28 +0000 (GMT)
>
> > I dont know very much about the workings of sound cards, but the problem 
>is
> > that when playing anything a total crackling in the background that 
>makes
> > the audio almost unusable...a real pity.
>
>There are plenty of funnies in the i810 audio (actually mostly the driver
>just doesn't seem to want to lie down and behave not such the hardware).
>The crackling audio isn't one of the problems seen anywhere.
>

A friend of mine with the same machine ( a tiny p4 1500 based machine ) 
suffers from this also, but they bought a commercial driver ( OSS?, im not 
sure.. ) that fixed the problem, there a couple of mentions of it on 
dejagoo, but no solutions offered.

>What AC97 codec is attached to your card, and also does it help if you
>turn volume levels down a bit and turn all the recording inputs right off ?

This is some of my dmesg info :

Intel 810 + AC97 Audio, version 0.21, 00:53:47 Feb 27 2002
PCI: Found IRQ 10 for device 00:1f.5
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xe000 and 0xdc00, IRQ 10
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
ac97_codec: AC97 Modem codec, id: 0x5349:0x4c22 (Silicon Laboratory Si3036)
i810_audio: timed out waiting for codec 1 analog ready




_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.


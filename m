Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280022AbRKDQjq>; Sun, 4 Nov 2001 11:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280026AbRKDQjg>; Sun, 4 Nov 2001 11:39:36 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:21714 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S280022AbRKDQjS>; Sun, 4 Nov 2001 11:39:18 -0500
Date: Sun, 4 Nov 2001 17:39:01 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: emu10k emits buzzing and crackling
In-Reply-To: <20011101200955.A1913@redhat.com>
Message-ID: <Pine.LNX.4.33.0111041737330.3150-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Benjamin LaHaise wrote:

> Hey folks,
> 
> One of the workstations I use really doesn't like the emu10k driver in 
> 2.4.13-ac5.  The box is a dual athlon running rh7.2.  Playing mp3s seems 
> to work well, but other samples from xfce on shutdown and window close 
> result in buzzing and popping noises.

Which program is used to play these?

Rui Sousa

>  If anyone wants details or patches 
> tested, drop me a note.
> 
> 		-ben
> 
> es1371: version v0.30 time 17:42:30 Nov  1 2001
> Creative EMU10K1 PCI Audio Driver, version 0.16, 17:42:24 Nov  1 2001
> emu10k1: EMU10K1 rev 7 model 0x8040 found, IO at 0x2400-0x241f, IRQ 19
> ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
> usb.c: registered new driver hub
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


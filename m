Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbREBIzy>; Wed, 2 May 2001 04:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbREBIzq>; Wed, 2 May 2001 04:55:46 -0400
Received: from www.teaparty.net ([216.235.253.180]:27410 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132479AbREBIzf>;
	Wed, 2 May 2001 04:55:35 -0400
Date: Wed, 2 May 2001 09:55:33 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Russ Dill <Russ.Dill@asu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Breakage of opl3sax cards since 2.4.3 (at least)
In-Reply-To: <200105020850.BAA03703@smtp.asu.edu>
Message-ID: <Pine.LNX.4.10.10105020953020.18977-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Russ Dill wrote:

> On 02 May 2001 09:30:03 +0100, Vivek Dasmohapatra wrote:
> 
> > I have an isapnp opl3sax system [2.4.3-ac5] - the sound card
> > initialises
[cut] 
> not quite, you seem to have a YMH0802, while I have a YMH0802, what
> error were you originally getting?

ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
opl3sa2: Activated ISA PnP card 0 (active=1)
opl3sa2: chipset version = 0x4
opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)
<OPL3-SA3> at 0x100
<MS Sound System (CS4231)> at 0xe84 irq 5 dma 1,3
<MPU-401 0.0  Midi interface #1> at 0x300 irq 5
opl3sa2: Search for a card at 0x904.
opl3sa2: Control I/O port 0x388 is not a YMF7xx chipset!
opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
opl3sa2: Control I/O port 0x388 is not a YMF7xx chipset!
opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
opl3sa2: Control I/O port 0x388 is not a YMF7xx chipset!
opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996

-- 
If voting could change things, it would be illegal.


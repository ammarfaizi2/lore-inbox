Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSE2Mdm>; Wed, 29 May 2002 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSE2Mdl>; Wed, 29 May 2002 08:33:41 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:26700 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S315222AbSE2Mdk>; Wed, 29 May 2002 08:33:40 -0400
Date: Wed, 29 May 2002 23:18:14 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: odd timer bug, similar to VIA 686a symptoms
In-Reply-To: <1022676387.4124.162.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10205292316380.3388-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2002, Alan Cox wrote:

> On Wed, 2002-05-29 at 10:25, Neale Banks wrote:
> >> May 28 11:19:54 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65485 [0xffcd]
> > May 28 11:19:55 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> > May 28 11:19:56 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> > May 28 11:19:57 gull kernel: timer.c: VIA bug check triggered. Value read 65499 [0xffdb], re-read 65484 [0xffcc]
> > May 28 11:19:58 gull kernel: timer.c: VIA bug check triggered. Value read 65497 [0xffd9], re-read 65483 [0xffcb]
> > 
> > Anyone got any good theories what's going on here, given that this is a
> > ~1995 vintage laptop with a Pentium-120 (which I'm assured doesn't have a
> > VIA 686a ;-)?
> 
> Neptune chipsets at least had latching bugs on timer reads. What chipset
> is the laptop ?

Does it help in that it's got a CMD640?  If not, what am I looking for?

Thanks,
Neale.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSH1TPG>; Wed, 28 Aug 2002 15:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSH1TPG>; Wed, 28 Aug 2002 15:15:06 -0400
Received: from [200.255.184.105] ([200.255.184.105]:19851 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S318907AbSH1TPF>; Wed, 28 Aug 2002 15:15:05 -0400
Date: Wed, 28 Aug 2002 16:19:13 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: ECS K7S5A: IDE performance
In-Reply-To: <20020828190650.GC16018@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0208281611210.213-100000@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Tomas Szepe wrote:

> > I have an ECS K7S5A 3.1A. It works fine with 2.4.19. No
> > corruption. Now I tested it with hdparm and:
> >
> > hdparm -tT /dev/hda
> >
> > /dev/hda:
> >  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec
> >
> > Only 38.10 ?
>
> How do you mean, only 38.10?

I just thought it'd be much more with an ATA100. I got more or
less the same with my earlier motherboard, an ASUS A7APro, and
without ATA66 - which would print a lot of CRC errors at boot
time if enabled in the BIOS. The K7S5A doesn't print any and is
rock solid.

Maybe running it at 100/133 (and not 100/100) decreases
performance ? I read is somewhere. I have an Athlon 1000 (200)
with 2x256Mb DDR PC2100.

-- 
0@pervalidus.{net, {dyndns.}org} ICQ: 156552241
Tel: +55 (21) 2717-2399 (with voice mailbox)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319065AbSH1X6U>; Wed, 28 Aug 2002 19:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSH1X6R>; Wed, 28 Aug 2002 19:58:17 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:25779 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S319063AbSH1X6N>; Wed, 28 Aug 2002 19:58:13 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ECS K7S5A: IDE performance
Date: Thu, 29 Aug 2002 02:05:56 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208290205.56291.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Frédéric L. W. Meunier wrote:
>
> > I just thought it'd be much more with an ATA100. I got more or
> > less the same with my earlier motherboard, an ASUS A7APro, and
> > without ATA66 - which would print a lot of CRC errors at boot
> > time if enabled in the BIOS. The K7S5A doesn't print any and is
> > rock solid.
>
> If you're reading more than the size of your on-drive buffer then you'll be
> limited by the speed at which the information can be grabbed off the
> drive--in your case, 38.1MB/s, which is quite good.

IBM (Yes, I konw...;-) IC35L060AVER07 (the whole family) is at 45,6 MB/s.
Maxtor 80 GB nearly the same.

System: AMD 750 (ATA4) and 760 MPX (ATA5).

> ATA33/66/100/133 only makes a significant difference in speed when you're
> reading from the on-drive cache.

Or maybe ATA RAID...;-)

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)


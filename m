Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRGDVz0>; Wed, 4 Jul 2001 17:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266558AbRGDVzR>; Wed, 4 Jul 2001 17:55:17 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:62120 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S266557AbRGDVzH>; Wed, 4 Jul 2001 17:55:07 -0400
Message-ID: <3B43BB18.CCCD4BEB@adelphia.net>
Date: Wed, 04 Jul 2001 17:55:52 -0700
From: Stephen Wille Padnos <stephenwp@adelphia.net>
Organization: Thoth Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: joe.mathewson@btinternet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] Suitable Athlon Motherboard for Linux
In-Reply-To: <200107041849.f64InoE12398@ambassador.mathewson.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

I have an Acer AK73 Pro(A), with an Athlon 1.333 GHz (133 FSB).  I have never
had anuy lockup or data corruption problems.  I do run this system as a
dual-boot, usually under Win2K :(

The system is as follows:
Acer AK73 Pro(A)
Athlon (C) 1.333 GHz
IBM DTLA307060 60G IDE hard drive
Creative labs RW1210E CD rewriter
IOmega Zip250
Matrox G450
Creative SB Live Value 5.1
D-Link network card (RTL8139)

Pretty much the exact equipment that everyone complains about, but I can
recompile kernels (fast!), copy large files, play music, and drag windows
around in X - without any problems.  I haven't used this system under Linux too
much, so I can't say for sure that it is much better than other Via-based
systems, but it does seem to be better.  I haven't done any tweaking to the
stock RH7.1 install, except for building a 2.4.4 kernel (I'm on the Win2K boot
now - I can't remember if I had Athlon optimizations on or not).

There are several things that I did with this system:
First, I got a big power supply - 400 watts.  This is with 1 hard drive, and
only 3 I/O cards.

Second, I got one of the AMD retail CPU's.  The difference in price was small
(maybe 10%), and it includes a GUARANTEED good fan - plus it has a 3-year
warrantee.

Third, I didn't buy the cheapest motherboard on the market.  I have had
excellent experiences with Acer products (since the '486 days), and this is one
more positive experience for me.

Let me know if you would like my kernel .config for experimentation. (not that
I have done anything great to it - it just seems to work :)

- Steve

Joseph Mathewson wrote:

[snip]

> I can't see much alternative to Via chipsets in the Ahtlon market, other
> than all-in-one-graphics-sound-network jobbies that, from previous
> experience (namely the i810), are also best avoided.
>
> Joe.
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbRGEGwe>; Thu, 5 Jul 2001 02:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266635AbRGEGwY>; Thu, 5 Jul 2001 02:52:24 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:21133 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S266633AbRGEGwL>; Thu, 5 Jul 2001 02:52:11 -0400
Subject: Re: >128 MB RAM stability problems (again)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01Jul4.172916edt.62972@gpu.utcc.utoronto.ca>
In-Reply-To: <01Jul4.172916edt.62972@gpu.utcc.utoronto.ca>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 05 Jul 2001 10:44:25 +0200
Message-Id: <994322676.768.0.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Jul 2001 17:29:12 -0400, Chris Siebenmann wrote:
> You write:
> | I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> | my house with more than 128 MB RAM?!? Can someone please point out to me
> | that he's actually running kernel-2.4.x on a machine with more than 128
> | MB RAM and that he's NOT having severe stability problems?
> 
>  Me. Two machines. (Both 2.4.5 high -ac kernels.)
> 
>  I strongly suggest getting memtest86 and running it on all of your
> problematic machines.

I ran memtest tonight on all machines....
It gave 0 errors on all of them.....

So.... this leads to the conclusion that the memory is okay, and that
something else must be the problem.... Could it still be a failing power
supply or something? It seems both computers have a 230 W power supply.
Might be a problem, I guess, I can buy a 400 W thingy if that makes
sense.

Other solutions I heard:
- antistatic wrist strap: already have one :-)
- BIOS fiddling... What exactly should I look for? They are, as far as I
can see, identical memory sticks, probably both from different
suppliers, but besides that quite the same....
- are there different brands of memory of different quality and might
that be a possible cause of the problems? And if so - what are good
memory brands and what are the bad ones?
- I mixed different types of SDRAM... Could be it.... My mainboard
manual is not really clear about this.... And I have no clue what brand
of memory I bought... they are all 133 MHz SDRAM sticks, some 64 MB,
some 128 MB.... MB manual says it can handle all 64/128 MB sticks...
- <your solution here :-)>

Anyway, thanks for any advice until now and thanks for listening again,
hope to hear more solutions.

--
Ronald Bultje


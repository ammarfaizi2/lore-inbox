Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273077AbRIIWMc>; Sun, 9 Sep 2001 18:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273078AbRIIWMW>; Sun, 9 Sep 2001 18:12:22 -0400
Received: from femail47.sdc1.sfba.home.com ([24.254.60.41]:51412 "EHLO
	femail47.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273077AbRIIWML>; Sun, 9 Sep 2001 18:12:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Carsten Leonhardt <leo@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Athlon/K7-Opimisation problems
Date: Sun, 9 Sep 2001 15:11:54 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de>
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de>
MIME-Version: 1.0
Message-Id: <01090915115400.00173@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 September 2001 10:07 am, Carsten Leonhardt wrote:
> Hi,
>
> here's my data regarding the K7 optimisation problem.
>
> Until last week I had a 1GHz Athlon with 133MHz FSB. I then bought a
> 1.4GHz Athlon, again 133MHz FSB.
>
> I never had any problems with the 1GHz processor, but as soon as I
> stuck the 1.4GHz processor in, the kernel oopsed itself to
> oblivion. (That was with kernel 2.4.5-ac5, approximately)

This is common enough it's becoming absurd.

>
> I also noticed that the computer booted ok with the Debian
> bootfloppies, which use a kernel compiled for i386. So after several
> kernel compile/boot cycles, I found out that I had to disable K7
> optimisation to make the system boot again.
>
> The mainboard is a Tyan Trinity KT-A (S2390B) with a VIA KT133A
> chipset.
>
> After reading here that it may be the PSU, I upgraded my 300W PSU to a
> 431W Enermax, which made no difference.
>
> The only difference I can make out between the working and the
> non-working CPU is the internal clockspeed of the CPU and the
> stepping (old: 2, new: 4).

Heat anyone? stepping 4 hasn't seemed to be the problem, at least not 
directly
What's the tempature difference between your 1Ghz and 1.4Ghz? both CPU 
and system? What kind of cooling do you have?

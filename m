Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272652AbRHaJhI>; Fri, 31 Aug 2001 05:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272647AbRHaJg7>; Fri, 31 Aug 2001 05:36:59 -0400
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:57755 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272648AbRHaJgn>; Fri, 31 Aug 2001 05:36:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Arjan van de Ven <arjanv@redhat.com>, Chris Abbey <linux@cabbey.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Fri, 31 Aug 2001 02:36:19 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net> <Pine.LNX.4.33.0108302353380.4964-100000@tweedle.cabbey.net> <3B8F4A64.8B9DEDE4@redhat.com>
In-Reply-To: <3B8F4A64.8B9DEDE4@redhat.com>
MIME-Version: 1.0
Message-Id: <01083102361900.00249@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 August 2001 01:27 am, Arjan van de Ven wrote:

<snip>

> Now I also wrote the 2 functions in question, and I am
> very convinced that they are correct. They also work on
> the vast majority of motherboards, and most of the failure
> cases are cheaper motherboards (or cheap PSU's).

Want cheap hardware?
Slot-A Athlon 800Mhz non-tbird
Soyo K7VIA motherboard, VIA KX133 chipset
Generic 300W power supply bought from mwave

and, for the other hardware:

1 DVD-ROM drive
1 Plextor PlexWriter CD-RW drive
1 IBM 75GXP 7200RPM 45GB ATA/100 drive
1 Promise ATA/100 HDD controller
1 350MB Western Digital Caviar drive, but this powers down completely 
when not in use
2 Generic 80mm case fans
1 low-end HSF unit with three small fans
1 GeForce2MX
1 stick of generic 256MB PC133 SDRAM that refuses to run at 133Mhz
1 ISA NIC
1 PCI NIC
1 floppy drive, sony I think, otherwise generic

I have never experienced problems with Athlon optimizations, and I 
*always* compile with them enabled.

Prehaps the key lies in Thunderbird vs Non-Thunderbird? When did these 
problems start showing up, and at what clock speeds? What motherboards? 
What chipsets?

>Greetings,
>     Arjan van de Ven

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFQPcz>; Mon, 17 Jun 2002 11:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSFQPcy>; Mon, 17 Jun 2002 11:32:54 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:11393 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314422AbSFQPcx>; Mon, 17 Jun 2002 11:32:53 -0400
Date: Mon, 17 Jun 2002 17:05:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 hardlock w/ hdparm
In-Reply-To: <3D0DE4CC.9010901@inet6.fr>
Message-ID: <Pine.LNX.4.44.0206171704070.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Lionel Bouton wrote:

> Unless the SiS620 is not compatable with the 630 IDE support spec or 
> affected by some bugs I corrected for PIO mode timings (unlikely as they 
> were unnoticed for a quiet long time) since sis5513.c v0.11 this should 
> not be an IDE chipset problem.

Nope definitely not, i've had a chance to dig a little deeper.

> Hum, 486 SiS chipsets might bring pain to me also...
> I've received several bugreports for old SiS IDE chipset (ie pre ATA66) 
> that I couldn't solve without disabling the SiS driver or passing 
> "ide=nodma". I've triple-checked the specs and couldn't see the problem.

That one is just for fun ;) ditto for the 386 w/ IDE box i just got =)

Cheers,
	Zwane
-- 
http://function.linuxpower.ca
		


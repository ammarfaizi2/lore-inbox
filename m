Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRH0U5V>; Mon, 27 Aug 2001 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRH0U5L>; Mon, 27 Aug 2001 16:57:11 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:11222 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268916AbRH0U5J>; Mon, 27 Aug 2001 16:57:09 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE0B8@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: jan@gondor.com, Dieter.Nuetzel@hamburg.de, linux-kernel@vger.kernel.org,
        mpet@bigfoot.de
Subject: RE: VCool - cool your Athlon/Duron during idle
Date: Mon, 27 Aug 2001 13:57:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > handle a too-hot cpu, but all C2/C3 gets you is reduced power when =
> > idle.
> > This results in better battery life on a laptop but that is 
> irrelevant =
> > on a
> > desktop system.
> 
> Thus speaks the country with chronic californian power 
> shortages, and that
> wouldn't sign up to a global accord on global warming 8)

Hehe. Not my fault, I'm an Oregonian! :)

> C2 and C3 are useful IMHO even on a desktop PC. The slight hit on the
> transition is not noticable, the change on the power bill is.

Of course, I agree. However, my point was that it is not safe to use them
until the platform explicitly supports them. Validating this on desktop
motherboards has traditionally not been deemed worthwhile, though I share
your hope that that changes.

Regards -- Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265674AbSJXUzp>; Thu, 24 Oct 2002 16:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265678AbSJXUzp>; Thu, 24 Oct 2002 16:55:45 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:17083 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265674AbSJXUzo> convert rfc822-to-8bit; Thu, 24 Oct 2002 16:55:44 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 23:01:53 +0200
User-Agent: KMail/1.4.7
Cc: Manfred Spraul <manfred@colorfullife.com>, Robert Love <rml@tech9.net>
References: <200210242251.26776.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200210242251.26776.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210242301.53292.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Oktober 2002 22:51 schrieb Dieter Nützel:
> Rober Love wrote:
> > The majority of the program is inline assembly so I do not think
> > compiler is playing a huge role here.
>
> I think they are...
>
> > Regardless, the numbers are all pretty uniform in saying the new no
> > prefetch method is superior so its a mute point.
>
> But all "your" numbers are slow.
> Look at mine with the "right" (TM) flags ;-)
>
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) MP 1900+

Ups, lost something during cut'n paste:

dual Athlon MP 1900+
MSI MS-6501 Rev 1.0 (aka K7D Master-L), AMD 760MPX, BIOS 1.5
2x 512MB DDR266, CL2, unregistered, NO ECC (stinky "normal" stuff ;-)

Cheers,
	Dieter

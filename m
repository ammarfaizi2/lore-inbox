Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289515AbSAVWnM>; Tue, 22 Jan 2002 17:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289516AbSAVWnD>; Tue, 22 Jan 2002 17:43:03 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:34763 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289515AbSAVWms>; Tue, 22 Jan 2002 17:42:48 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Tue, 22 Jan 2002 23:42:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201222310260.13313-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201222310260.13313-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020122224257Z289515-13997+8587@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 23:21, Daniel Nofftz wrote:
> On Tue, 22 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > Maybe it's time for AMD/VIA/SiS/Nvidia, etc. to come up with there code
> > for _ALL_ Athlon/Duron chipsets???
> > As we are in trouble with AMD 4MB pages, yet.
> >
> > Have a look at www.vcool.de
>
> yes ... maybee ... the problem is , that the disconnect-function  is
> enabled by the chipset ... and it is a different register in every
> different chipset. so it is a little bit difficult to make a solution for
> all chipsets.

I know that and my intention was that we _NEED_ documentation to support it 
on _ALL_ chipsets out there.

AMD should notice how many people using there CPUs and I think they do know 
it.

So let's make a call.

> by the way ... i know www.vcool.de ... my work is partialy based on this.
> but the vcool linux patch/version does not support kt266/kt266a chipset.
> (only the kt/kx133 chipset)

I know.

> after some mail exchange with the developer of vcool,

I did that, too.
Andreas Jaeger (SuSE) told me that maybe he could help.
He got the USB patch information for the AMD Irongate after a few days out of 
them...

> i decided to wrote a kernelpatch, which supports the kt266/kt266a chipset
> too.

Good work.

> (one of my reasosns for this was, that the developer of vcool will not
> develop the linux version further) .

Sadly to hear.

> the second thing is, that this patch is a little bit simpler then the
> (l)vcool approach ... i think ... :)

I can't compare 'cause I have the AMD Irongate C4...;-)

> ah ... if someone sends me the the needed informations, which registers
> (or register-bits) are to be changed on ther chipsets to activate the
> disconnect-function, i will add this chipsets to the patch.

I hope we get some info, now.

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

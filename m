Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSLOMYO>; Sun, 15 Dec 2002 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSLOMYN>; Sun, 15 Dec 2002 07:24:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9210 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266478AbSLOMYL>; Sun, 15 Dec 2002 07:24:11 -0500
Date: Sun, 15 Dec 2002 13:32:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Networking/Becker et al [was Re: pci-skeleton duplex check]
Message-ID: <20021215123159.GJ27658@fs.tum.de>
References: <20021213092229.D9973@work.bitmover.com> <1039898841.855.1684.camel@phantasy> <athjft$4b7$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <athjft$4b7$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 09:54:05AM +0000, Henning P. Schmiedehausen wrote:
> Robert Love <rml@tech9.net> writes:
> 
> >On Sat, 2002-12-14 at 08:28, Henning P. Schmiedehausen wrote:
> 
> >> e) put an alan-cox-like entity between him and the linux kernel developers
> >>    which translates. Worked terrific for Andre Hedrick. :-)
> 
> >Isn't that what Jeff is?
> 
> Yes. And he does a great job. But the second he started to put
> something in that he maintains in his subsystem, another obnoxious
> developer with too much spare time popped up and started whining about
> "don't put this crap in, Marcello". Of course, without offering any
> alternative.

I remember the mail you were referring to but I don't have any knowledge 
regarding whether this specific patch is good or bad.

It's often better to reject bad code and to have nothing in the kernel 
instead of having bad code in the kernel. There are several examples 
where bad code entered into the kernel and it would have been better if 
it was rejected.

You might discuss whether the code in question is "crap" or good code 
but please discuss it on a technical level without personal offences.

> 	Regards
> 		Henning

cu
Adrian

-- 

Deutsches Grundgesetz, Artikel 1, Absatz 1, Satz 1:

  Die Wuerde des Menschen ist unantastbar.



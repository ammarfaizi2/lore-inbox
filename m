Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSEHS3j>; Wed, 8 May 2002 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSEHS3i>; Wed, 8 May 2002 14:29:38 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:21216 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S314841AbSEHS3g>;
	Wed, 8 May 2002 14:29:36 -0400
Date: Wed, 8 May 2002 20:28:57 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Padraig Brady <padraig@antefacto.com>
cc: Tomasz Rola <rtomek@cis.com.pl>, mikeH <mikeH@notnowlewis.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: lost interrupt
In-Reply-To: <3CD921F2.5070605@antefacto.com>
Message-ID: <Pine.LNX.3.96.1020508202804.2181F-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 8 May 2002, Padraig Brady wrote:

> Tomasz Rola wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On Tue, 7 May 2002, mikeH wrote:
> > 
> > 
> >>Sorry if this is a repeat, I didn't see my last post come through...
> >>
> >>I'm being plauged with "hdX: lost interrupt" messages and resultant 
> >>system hangs in kernel 2.4.18 on a via 82XXXX chipset.
> > 
> > 
> > I may not be the right person to answer but I had same problem (same via,
> > same kernel, same interrupt). It helped when I turned unmasking off, i.e.
> > try:
> > 
> > hdparm -u0 /dev/hdX  for every X in existing disks you have problems with.
> > 
> 
> unmasking is already off on my drive

My so called competence ends here...

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPNlufBETUsyL9vbiEQJeSQCeJSy+osD5VoiC7ykENLB1vfxfFmAAnicQ
Ztwl52/RkGXuXej5rCvrNlEV
=cfx4
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSEHCNk>; Tue, 7 May 2002 22:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSEHCNj>; Tue, 7 May 2002 22:13:39 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:28593 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S315480AbSEHCNj>;
	Tue, 7 May 2002 22:13:39 -0400
Date: Wed, 8 May 2002 04:14:25 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
cc: Tomasz Rola <rtomek@cis.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: Can't Burn CDR's On 2.4.19pre8
In-Reply-To: <20020507212201.GA12699@mail-infomine.ucr.edu>
Message-ID: <Pine.LNX.3.96.1020508040909.2702J-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 7 May 2002, Johannes Ruscheinski wrote:

> Also sprach Tomasz Rola:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On Mon, 6 May 2002, Johannes Ruscheinski wrote:
> > 
> > > Hi,
> > > 
> > > I don't know whether I have a hardware problem or a kernel problem.  Here's
> > > what I get when I try to dummy burn a data CDR on 2.4.19pre8:
> > > 
> > 
> > Forgive me this insulting question, but have you tried to burn another CD?
> It was a dummy burn.  I didn't realize that the CDR medium mattered here?
> So just to be on the safe side I tried again with a different brand disc
> and had a failure after about 70MiB of data.

Me idiot. Haven't noticed that "dummy" word. How about going back to some
previous working kernel to try if it works? I have burnt quite a few CDRWs
under 2.4.18 so I assume it's ok here. BTW, I always give right dev=x,y,z
options, which I get from "cdrecord -scanbus".

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

iQA/AwUBPNiKCBETUsyL9vbiEQKLmQCgjykrGtGsrdZxkwgegm/saT029DEAoNNm
VeREzT/A9X6ga1D56XPZX2ly
=HBJv
-----END PGP SIGNATURE-----


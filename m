Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S262919AbUJ1UG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUJ1UG5 (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 28 Oct 2004 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUJ1UDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:03:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3079 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262895AbUJ1UAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:00:20 -0400
Date: Thu, 28 Oct 2004 21:59:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Larry McVoy <lm@work.bitmover.com>, Xavier Bestel <xavier.bestel@free.fr>,
        Larry McVoy <lm@bitmover.com>, James Bruce <bruce@andrew.cmu.edu>,
        Linus Torvalds <torvalds@osdl.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andrea Arcangeli <andrea@novell.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041028195947.GD3207@stusta.de>
References: <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041028151004.GA3934@work.bitmover.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Oct 28, 2004 at 08:10:04AM -0700, Larry McVoy wrote:
> On Thu, Oct 28, 2004 at 04:06:20PM +0200, Xavier Bestel wrote:
> > Le jeu 28/10/2004 ?? 15:53, Larry McVoy a ??crit :
> > 
> > > The reason it is worded that way is so that we avoid the situation where
> > > one guy is doing the work on $SCM and the other guy is sitting there 
> > > running BK commands in order to reverse engineer BK.
> > 
> > I don't think you can stop that from happening, legally.
> 
> Since you haven't paid for the product, copyright law applies and
> that's quite different than contract law.  You get a certain set
> of rights, which vary worldwide, when you buy something.  Copyright
> is far more restrictive.

US copyright law isn't the only one in the world...

> "Fair use" != "reverse engineering" in any venue so far as I know.

German copyright law explicitely allows every person allowed to use a 
program to observe and test this program for getting the ideas behind 
the program as long as you can do this through normal usage of the 
program.

If you aren't building a similar program but require disassembling for 
interoperability, this is explicitely allowded.

According to German copyright law, any licence clauses that violate 
these rules are void [1].

Note that German copyright lay doesn't differentiate whether you paid 
or not - it only requires that you allowed to use the program.

> As always, IANAL, so contact yours for clarification.

These are paragraphs 69d(3), 69e and 69g(2) of German copyright law - 
IANAL, but the text of the law is pretty unambiguous.

cu
Adrian

[1] the clauses are void, not the licence itself

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgU+zmfzqmE8StAARAv9PAJ9klSxSbl8zi9kKv2MI96oq0r0pggCdHTDv
tMik8nm1bVB5seygLyQfmgc=
=kTsy
-----END PGP SIGNATURE-----

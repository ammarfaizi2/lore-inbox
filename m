Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSLBCix>; Sun, 1 Dec 2002 21:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSLBCix>; Sun, 1 Dec 2002 21:38:53 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:39878 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S263837AbSLBCiv>; Sun, 1 Dec 2002 21:38:51 -0500
Date: Sun, 1 Dec 2002 18:46:21 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: Eric Blade <eblade@blackmagik.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DRM/DRI issue with Radeon
Message-Id: <20021201184621.14576d1c.joshk@mspencer.net>
In-Reply-To: <1038790613.4691.757.camel@cpq>
References: <20021201143233.MIKG4739.fep01-svc.ttyl.com@localhost>
	<20021201124208.16b0ae70.joshk@mspencer.net>
	<1038790613.4691.757.camel@cpq>
X-Mailer: Sylpheed version 0.8.6cvs7 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.,o86s'cArWk56l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.,o86s'cArWk56l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I think it makes sense, since DRI is designed to work on top of agpgart.
Can someone confirm this guess for me? Or make me look like a moron?

BTW, the following quoted message was not posted to lkml previously, so
I am attaching it in its entirety.

-Josh

Rabid cheeseburgers forced Eric Blade<eblade@blackmagik.dynup.net> to
write this on 01 Dec 2002 19:56:42-0500:	

> On Sun, 2002-12-01 at 15:42, Joshua Kwan wrote:
> > I'm stumped, really. Try building it INTO the kernel (ie Y instead
> > of M.) This is what I did and it works. Or maybe you should get
> > XFree86 4.2.1, which is what I have: 
> 
> 
> This has little to do with the topic at hand, but I figured since we
> were discussing the Radeon and DRM/DRI, I thought I'd ask this one.
> 
>  Am I correct in my assumption that the Radeon DRI code does not work
> with PCI versions of the Radeon?  I have a Radeon 7500 PCI (since this
> box that's designed as a "server" doesn't have AGP ports), and have
> been completely unable to get DRI to work at all.  I didn't have any
> problems on my other box, which has an AGP Voodoo 3 in it.
> 
>   Thanks,
>       - Eric
> 
> 

--=.,o86s'cArWk56l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE96sl/6TRUxq22Mx4RAuSUAJsGQZY3f2FIMY77LUKqJ6Tr9tG8HACgggQD
FDNh6irzNn7EjlHoaIFjIn4=
=JgmT
-----END PGP SIGNATURE-----

--=.,o86s'cArWk56l--

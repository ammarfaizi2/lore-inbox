Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVAGWiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVAGWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVAGWce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:32:34 -0500
Received: from marla.ludost.net ([194.12.255.250]:33246 "EHLO marla.ludost.net")
	by vger.kernel.org with ESMTP id S261679AbVAGW0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:26:47 -0500
Subject: Re: Fix for new elf_loader bug?
From: Vasil Kolev <vasil@ludost.net>
Reply-To: vasil@ludost.net
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050107170514.GJ29176@logos.cnet>
References: <41DEAF8F.3030107@bio.ifi.lmu.de>
	 <20050107170514.GJ29176@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6j9MLNBLXe9Akzoa+6eb"
Organization: Ludost Networks
Date: Sat, 08 Jan 2005 00:26:39 +0200
Message-Id: <1105136799.1644.1.camel@doom.home.ludost.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6j9MLNBLXe9Akzoa+6eb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On =D0=BF=D1=82, 2005-01-07 at 15:05 -0200, Marcelo Tosatti wrote:
> On Fri, Jan 07, 2005 at 04:49:35PM +0100, Frank Steiner wrote:
> > Hi,
> >=20
> > is there already a patch for the new problem with the elf loader, maybe
> > in the bitkeeper tree?
> >=20
> > http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt
>=20
> 2.6.10-ac6 contains a fix for the problem - a similar version should hit =
the BK tree=20
> RSN.

Looking at the advisory, it affects 2.4, too, where can a patch for it
be found?=20

--=-6j9MLNBLXe9Akzoa+6eb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB3wyfXGxMwFp5iTARAsqsAJ4sUctAor7COX8g1UJ9PoZLeWOmLwCgiEnB
u0wXwynuPtUAXYftVThdzZw=
=XoH6
-----END PGP SIGNATURE-----

--=-6j9MLNBLXe9Akzoa+6eb--


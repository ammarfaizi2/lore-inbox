Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUAEPnC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUAEPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:42:48 -0500
Received: from [68.114.43.143] ([68.114.43.143]:20387 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S265144AbUAEPme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:42:34 -0500
Date: Mon, 5 Jan 2004 10:42:31 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap bug and 2.4?
Message-ID: <20040105154231.GD2247@rdlg.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I love you guys.  Yeah, I have to compile a new kernel, test it  and push i=
t out
this week to 600 machines but atleast I don't have to wait 6 months and
then hope it doesn't kill all my apps.

You guys are great, THANKS!

Robert


Thus spake Marcelo Tosatti (marcelo.tosatti@cyclades.com):

>=20
>=20
> On Mon, 5 Jan 2004, Robert L. Harris wrote:
>=20
> >
> >
> > Just read this on full disclosure:
> >
> > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> >
> > Is it valid?  No working proof of concept code has been posted so I can=
't
> > test my systems.  The article only lists 2.4 and 2.6.  Is this
> > 2.4.16-current, etc?  Anyone have any details about versions that are
> > safe so I/We can determine if I need to roll a new production kernel out
> > again?
>=20
> It is possible that the problem is exploitable. There is no known public
> exploit yet, however.
>=20
> 2.4.24 includes a fix for this (mm/mremap.c diff)

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+YXn8+1vMONE2jsRAmp0AJ45mWWjqNl8WEzxAl+PyXH24gB+NgCglWYo
yEIqatwOh/qgy88BLbodxrA=
=04FO
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVHMSt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVHMSt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHMSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:49:58 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:1950 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S932254AbVHMSt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:49:58 -0400
Date: Sat, 13 Aug 2005 19:49:51 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Stephen Pollei <stephen.pollei@gmail.com>,
       Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050813184951.GA8283@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Lee Revell <rlrevell@joe-job.com>,
	Stephen Pollei <stephen.pollei@gmail.com>,
	Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
	linux-kernel@vger.kernel.org
References: <42FDE286.40707@v.loewis.de> <feed8cdd0508130935622387db@mail.gmail.com> <1123958572.11295.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1123958572.11295.7.camel@mindpipe>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 13, 2005 at 02:42:52PM -0400, Lee Revell wrote:
> On Sat, 2005-08-13 at 09:35 -0700, Stephen Pollei wrote:
> > Thats great for the perl6 people.
> > http://dev.perl.org/perl6/doc/design/syn/S03.html says they are going
> > to be using =AB and =BB as operators...
>=20
> Is Larry smoking crack?  That's one of the worst ideas I've heard in a
> long time.  There's no easy way to enter those at the keyboard!

   I have "setxkbmap -symbols 'en_US(pc102)+gb'" in my ~/.xsession,
and =AB and =BB are available as AltGr-z and AltGr-x respectively.

   Hugo.

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Anyone who claims their cryptographic protocol is secure is ---  =20
         either a genius or a fool.  Given the genius/fool ratio        =20
                 for our species,  the odds aren't good.                =20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC/kDPssJ7whwzWGARAh+6AJ92RSTSJ5L3jFNVFTZgBQle6j2LMQCgqV63
NWy7SDbhIXziaeAgcbpFtEQ=
=nzQ4
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

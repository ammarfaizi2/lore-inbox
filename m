Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280479AbRKJFQS>; Sat, 10 Nov 2001 00:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280494AbRKJFQJ>; Sat, 10 Nov 2001 00:16:09 -0500
Received: from panacea.canonical.org ([209.115.72.61]:55819 "HELO
	panacea.canonical.org") by vger.kernel.org with SMTP
	id <S280479AbRKJFQH>; Sat, 10 Nov 2001 00:16:07 -0500
Date: Sat, 10 Nov 2001 00:16:06 -0500
From: Jason Cook <jasonc@reinit.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bonding driver - linux kernel
Message-ID: <20011110001606.A18715@panacea.canonical.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1005299191.5985.32.camel@praetorian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1005299191.5985.32.camel@praetorian>; from aafes@psu.edu on Fri, Nov 09, 2001 at 04:46:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Phil Sorber (aafes@psu.edu) wrote:
> hello,
>=20
> i have an HP Procurve 4000M and a linux box with an Intel Pro/100 Dual
> Port Server Adapter (eepro.c). we have the switch set to do cicso
> etherchannel, which the procurve supports. but it seems not to work in
> this mode. we have to back down to trunking mode, giving us 200Mbit
> upstream, but only 100Mbit down stream.
>=20
> I was curious if it had been tested with any HP switches, or any non
> cisco switches for that matter that support cisco etherchannel. i was
> also wondering if this is not the case if anyone has written a patch, or
> is planning to write one to correct this.
>=20
> if not, me and my colleague and i are willing to take a crack at it.
> however we have limited experience at something like this, but are eager
> to get into it.
>=20
> any help or direction is apreciated. thanx.
>=20
> --=20
> Phil Sorber
> AIM: PSUdaemon
> IRC: irc.openprojects.net #psulug PSUdaemon
> GnuPG: keyserver - pgp.mit.edu

I thought only the 8000M could do etherchannel.

--=20
Jason Cook                 |  GnuPG Fingerprint: D531 F4F4 BDBF 41D1 514D
GNU/Linux Technical Lead   |                     F930 FD03 262E 5120 BEDD
evolServ Technology        |  Home page: http://reinit.org

Um, it's like, uh ... did anyone see the movie =14ron'?
	-- Homer Simpson

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvsuBYACgkQ/QMmLlEgvt13VgCfWsvY1UqsWn2OHtZiUGeDRc20
81YAn2EZamfSdmnSImShfYcw7XZisIUD
=oPVj
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

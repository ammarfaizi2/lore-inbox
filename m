Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSJaShb>; Thu, 31 Oct 2002 13:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJaShb>; Thu, 31 Oct 2002 13:37:31 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:45931 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265321AbSJaSh3>;
	Thu, 31 Oct 2002 13:37:29 -0500
Date: Thu, 31 Oct 2002 19:43:48 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Bernd Petrovitsch <bernd@gams.at>
Cc: Matt Porter <porter@cox.net>, Mark Mielke <mark@mark.mielke.cc>,
       Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031194348.A12469@jaquet.dk>
References: <20021031100855.A3407@home.com> <22051.1036083179@frodo.gams.co.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <22051.1036083179@frodo.gams.co.at>; from bernd@gams.at on Thu, Oct 31, 2002 at 05:52:59PM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 05:52:59PM +0100, Bernd Petrovitsch wrote:
> Matt Porter <porter@cox.net> wrote:
> >Thank you.  This is exactly why in the last CONFIG_TINY thread I made
> >it clear that a one-size-fits-all option is not all that helpful for
> >serious embedded systems designers.
> >
> >Collecting these parameters in a single tweaks.h file and perhaps using
> >things like CONFIG_TINY, CONFIG_DESKTOP, CONFIG_FOO as profile selectors
>=20
> In an ideal world there would be several options invidually=20
> selectable.

But there is? Please look at 2.5.44-config. Or did I misunderstand
you. Anyways, this work is far from the point where how this is
selected is a major concern.=20

Regards,
  Rasmus

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wXnklZJASZ6eJs4RAkt2AJ0Z8hoHZvJ3itLhRCMiSWdDjZB7lACcDvj8
N5rRM3++lzZcm51tqx4AZck=
=X58K
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

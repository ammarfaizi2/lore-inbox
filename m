Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVKHWBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVKHWBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVKHWBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:01:52 -0500
Received: from lug-owl.de ([195.71.106.12]:18329 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030373AbVKHWBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:01:52 -0500
Date: Tue, 8 Nov 2005 23:01:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adayadil Thomas <adayadil.thomas@gmail.com>
Cc: Chris Largret <largret@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Creating new System.map with modules symbol info
Message-ID: <20051108220148.GP27184@lug-owl.de>
Mail-Followup-To: Adayadil Thomas <adayadil.thomas@gmail.com>,
	Chris Largret <largret@gmail.com>, linux-kernel@vger.kernel.org
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com> <1131484787.5520.3.camel@shogun.daga.dyndns.org> <fb7befa20511081345l497846abla28f978fc4e45442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7Cw32JRT2J/IcDG"
Content-Disposition: inline
In-Reply-To: <fb7befa20511081345l497846abla28f978fc4e45442@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R7Cw32JRT2J/IcDG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-11-08 16:45:12 -0500, Adayadil Thomas <adayadil.thomas@gmail.c=
om> wrote:
> Thanks for the reply.
>=20
> Usage of mksysmap is --
> mksysmap vmlinux System.map
>=20
> How do I specify the module which is not included in the kernel ?
> Is that possible ?

Not with that script.

Look at /proc/kallsyms instead.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--R7Cw32JRT2J/IcDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcSBMHb1edYOZ4bsRAiRXAJ9njH4gz/JPcetnlK2Rb5toMTANJgCfb/Ix
2QVBrPqH9aXGy9HDd6SPBL4=
=fM3D
-----END PGP SIGNATURE-----

--R7Cw32JRT2J/IcDG--

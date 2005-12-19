Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVLSWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVLSWae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVLSWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:30:34 -0500
Received: from lug-owl.de ([195.71.106.12]:56205 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S964826AbVLSWad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:30:33 -0500
Date: Mon, 19 Dec 2005 23:30:30 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051219223030.GM13985@lug-owl.de>
Mail-Followup-To: Linda Walsh <lkml@tlinx.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <43A7304B.2070103@tlinx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hyrpr+DJ/h10HsVE"
Content-Disposition: inline
In-Reply-To: <43A7304B.2070103@tlinx.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hyrpr+DJ/h10HsVE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-12-19 14:12:27 -0800, Linda Walsh <lkml@tlinx.org> wrote:
> Ideally it would be good to be able to make an installable kernel
> package as a non-root user.  The idea is to not need root-privs
> except to install, right? :-)

That's how it is ment to be. Actually, for in-tree builds, you get the
tarball without first becoming root. I'll fix that soon, as I find
some spare minute to hack it :)

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

--hyrpr+DJ/h10HsVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDpzSGHb1edYOZ4bsRArggAJ9WA3yoQFVR+qUKssS4Xsn6bFeKPwCeM73B
FDFZTObzUrPQ3AAm9aTTo3w=
=hN79
-----END PGP SIGNATURE-----

--hyrpr+DJ/h10HsVE--

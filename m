Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUBEM30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUBEM30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:29:26 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:23745 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265141AbUBEM3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:29:24 -0500
Date: Thu, 5 Feb 2004 13:29:21 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
Message-ID: <20040205122921.GB28571@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040204200610.GB3802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lUFOiBjYbj2M+tdK"
Content-Disposition: inline
In-Reply-To: <20040204200610.GB3802@localhost.localdomain>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lUFOiBjYbj2M+tdK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-04 23:06:10 +0300, Andrey Borzenkov <arvidjaar@mail.ru>
wrote in message <20040204200610.GB3802@localhost.localdomain>:
> Any technical reaon IPV4 cannot be built as module? Current kernel
> barely fits on floopy (even with IDE as module); factoring out IPV4
> would allow to reduce size even more.

Some hard work need to be done to do that, but why shouldn't a kernel
fit onto a floppy? My vmlinuz'es are at about 600 to 900 KB for i386 and
a floppy can handle nearly about twice that size...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--lUFOiBjYbj2M+tdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAIjchHb1edYOZ4bsRAmolAJ9DDstwvdT5ukheKnJ/ZZkfiyTn/wCcCfNe
FyHQguBdVvAVh6ecwsu9O00=
=mC2A
-----END PGP SIGNATURE-----

--lUFOiBjYbj2M+tdK--

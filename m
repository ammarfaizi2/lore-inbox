Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVDUMPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDUMPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDUMPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:15:30 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:50598 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261327AbVDUMPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:15:18 -0400
Subject: Re: Linux 2.6.12-rc3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, pasky@ucw.cz
In-Reply-To: <20050421112022.GB2160@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
	 <20050421112022.GB2160@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1plBciCHXzFstvpHkp97"
Date: Thu, 21 Apr 2005 14:18:54 +0200
Message-Id: <1114085934.17551.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1plBciCHXzFstvpHkp97
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-21 at 13:20 +0200, Pavel Machek wrote:
> Hi!
>=20
> > And for the crazy people, the git archive on kernel.org is up and runni=
ng=20
> > under /pub/scm/linux/kernel/git/torvalds/linux-2.6.git. For the=20
> > adventurous of you, the name of the 2.6.12-rc3 release is a very nice a=
nd=20
> > readable:
> >=20
> > 	a2755a80f40e5794ddc20e00f781af9d6320fafb
> >=20
> > and eventually I'll try to make sure that I actually accompany all=20
> > releases with the SHA1 git name of the release signed with a digital=20
> > signature.=20
>=20
> As far as I can see... (working with pasky's version of git....)
>=20
> You should put this into .git/remotes
>=20
> linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.=
git
>=20
> Then
>=20
> RSYNC_FLAGS=3D-zavP git pull linus
>=20
> should do the right thing.
>=20

=46rom 0.5 or 0.6 you just have to do:

git init rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6=
.git

> [pasky, would it be possible to make some kind of progress indication
> default for long pulls?]
>=20

Latest seems to do the rsync verbose.


--=20
Martin Schlemmer


--=-1plBciCHXzFstvpHkp97
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZ5ouqburzKaJYLYRAhOdAJwNpLh1BNIH2I+QRsaAXl9EgkFj6gCfW8+o
PxxCvLS2FNJ/mhRQyciij8M=
=iZ7F
-----END PGP SIGNATURE-----

--=-1plBciCHXzFstvpHkp97--


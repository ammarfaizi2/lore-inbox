Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUGGOeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUGGOeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUGGOeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:34:13 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38616 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265151AbUGGOeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:34:09 -0400
Date: Wed, 7 Jul 2004 16:34:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707143407.GZ18841@lug-owl.de>
Mail-Followup-To: Tomas Szepe <szepe@pinerecords.com>,
	Ray Lee <ray-lk@madrabbit.org>, tomstdenis@yahoo.com,
	eger@havoc.gtf.org, Linux Kernel <linux-kernel@vger.kernel.org>
References: <1089165901.4373.175.camel@orca.madrabbit.org> <20040707073059.GA20079@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eOZ5LUtYRk41oVSR"
Content-Disposition: inline
In-Reply-To: <20040707073059.GA20079@louise.pinerecords.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eOZ5LUtYRk41oVSR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-07 09:30:59 +0200, Tomas Szepe <szepe@pinerecords.com>
wrote in message <20040707073059.GA20079@louise.pinerecords.com>:
> On Jul-06 2004, Tue, 19:05 -0700
> Ray Lee <ray-lk@madrabbit.org> wrote:
> > According to K&R, 2nd ed, section A2.5.1 (Integer Constants):
> >
> >         The type of an integer depends on its form, value and suffix.
> >         [...] If it is unsuffixed octal or hexadecimal, it has the first
> >         possible of these types ["in which its value can be represented"
> >         -- from omitted]: int, unsigned int, long int, unsigned long
> >         int.
>=20
> Is it safe to assume that C99 compilers append "..., long long int,
> unsigned long long int" to the list?

It is.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--eOZ5LUtYRk41oVSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7AnfHb1edYOZ4bsRAm8DAJ9pLd7PXS08spQorjOsmBKy8TVllACeM0nG
u38P7mxoBKkeNVAoEQBaV3s=
=vGxk
-----END PGP SIGNATURE-----

--eOZ5LUtYRk41oVSR--

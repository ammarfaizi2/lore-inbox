Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUJ0UUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUJ0UUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUJ0UQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:16:57 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:3057 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S262677AbUJ0UOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:14:07 -0400
Subject: Re: The naming wars continue... [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tonnerre <tonnerre@thundrix.ch>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
In-Reply-To: <417F2251.7010404@zytor.com>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>
	 <200410261442.11618.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041026203137.GB10119@thundrix.ch>  <417F2251.7010404@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VJpDWeIhWx6Pz0vzx/2G"
Date: Wed, 27 Oct 2004 22:13:38 +0200
Message-Id: <1098908018.12420.81.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VJpDWeIhWx6Pz0vzx/2G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-26 at 21:21 -0700, H. Peter Anvin wrote:
> Tonnerre wrote:
> > Salut,
> >=20
> > On Tue, Oct 26, 2004 at 02:43:54PM +0300, Denis Vlasenko wrote:
> >=20
> >>Having /usr/XnnRmm was a mistake in the first place.
> >=20
> >=20
> > BSD has /X11R6, whilst I'd agree that /opt/xorg is probably a lot more
> > appropriate. If you want I can  take this discussion back to the X.Org
> > folks again, but I don't think it's actually going to change anything.
> >=20
>=20
> /opt/X (or /usr/X) is really what it probably should be.
>=20

Except if I am missing something, it is (or was) to be able to
distinguish between versions that broke protocol compatibility ...
so except if the protocol will never change again, it should really
stay as is, and the apps should actually just start to use /usr/bin/X11
and /usr/lib/X11 that points to the latest or most stable instead of
the versioned directories ...


--=20
Martin Schlemmer


--=-VJpDWeIhWx6Pz0vzx/2G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgAFyqburzKaJYLYRAvrpAJ9UV7ecQ/lp0YhDQjnBq7cGFRYNlACff9LP
KfnR+zS6vwFbxa+7Ve7kMvo=
=iMTq
-----END PGP SIGNATURE-----

--=-VJpDWeIhWx6Pz0vzx/2G--


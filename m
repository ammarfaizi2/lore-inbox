Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbUJ0Vmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUJ0Vmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUJ0Vie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:38:34 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:42151 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S262917AbUJ0VfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:35:20 -0400
Subject: Re: The naming wars continue... [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
In-Reply-To: <41800675.5090806@osdl.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>
	 <200410261442.11618.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041026203137.GB10119@thundrix.ch>  <417F2251.7010404@zytor.com>
	 <1098908018.12420.81.camel@nosferatu.lan>  <41800675.5090806@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o8o5ouhHtQ01JDzQtHjp"
Date: Wed, 27 Oct 2004 23:35:07 +0200
Message-Id: <1098912907.12420.91.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o8o5ouhHtQ01JDzQtHjp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 13:35 -0700, Randy.Dunlap wrote:
> Martin Schlemmer [c] wrote:
> > On Tue, 2004-10-26 at 21:21 -0700, H. Peter Anvin wrote:
> >=20
> >>Tonnerre wrote:
> >>
> >>>Salut,
> >>>
> >>>On Tue, Oct 26, 2004 at 02:43:54PM +0300, Denis Vlasenko wrote:
> >>>
> >>>
> >>>>Having /usr/XnnRmm was a mistake in the first place.
> >>>
> >>>
> >>>BSD has /X11R6, whilst I'd agree that /opt/xorg is probably a lot more
> >>>appropriate. If you want I can  take this discussion back to the X.Org
> >>>folks again, but I don't think it's actually going to change anything.
> >>>
> >>
> >>/opt/X (or /usr/X) is really what it probably should be.
> >>
> >=20
> >=20
> > Except if I am missing something, it is (or was) to be able to
> > distinguish between versions that broke protocol compatibility ...
> > so except if the protocol will never change again, it should really
> > stay as is, and the apps should actually just start to use /usr/bin/X11
> > and /usr/lib/X11 that points to the latest or most stable instead of
> > the versioned directories ...
>=20
> This won't get fixed on lkml.
> If you want to contribute in this area, try LSB/FHS etc.  & Please do.
>=20

While I appreciate the thought, I should admit that I was only trying
to be the local smart-ass, so I have to decline to go on the LSB/FHS
crusade :/  Maybe one of the others before me would be so kind.


PS: I probably should point out that my use of /usr/bin/X11 and
    /usr/lib/X11 for the generic symlinks is not so generic, before
    I step on more toes ...


Thanks,

--=20
Martin Schlemmer


--=-o8o5ouhHtQ01JDzQtHjp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgBSKqburzKaJYLYRAsOuAJ47/3vIdWDyduSTehfHfFomZnufRwCeNzcp
d3Yms9QdYRQVD+Y9yo+saBA=
=DggB
-----END PGP SIGNATURE-----

--=-o8o5ouhHtQ01JDzQtHjp--


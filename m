Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbUJ2MlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUJ2MlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUJ2MlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:41:07 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44344 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263308AbUJ2Mk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:40:57 -0400
Date: Fri, 29 Oct 2004 06:43:08 -0600
From: Chad Christopher Giffin <typo@shaw.ca>
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
In-reply-to: <418226FA.1030803@grupopie.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>
Reply-to: typo@shaw.ca
Message-id: <1099053788.4511.13.camel@localhost>
Organization: T-Net Information Systems
MIME-version: 1.0
X-Mailer: Evolution 2.0.0
Content-type: multipart/signed; boundary="=-kNukLIvex/fOETd2ar+F";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1099032721.23148.5.camel@localhost> <418226FA.1030803@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kNukLIvex/fOETd2ar+F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-10-29 at 12:18 +0100, Paulo Marques wrote:
> Chad Christopher Giffin wrote:
> > I couldn't help but notice that the Linuxant Modem drivers appear to be
> > GPL'd, as a strings of the modules shows that License=3DGPL.
>=20
> There was a huge discussion about this in April. You should check this=20
> thread:
>=20
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D108303207819170&w=3D2

Thank you for bringing this to my attention. :-)=20

> Always search the archives before posting to LKML ;)

Yes, I see why.


Well then, it appears as though I have made a mistake which therefore
warrants a public request that:=20

Any recipients of my email to the Linux Kernel Mailing List, which had
attachment "keygen.pl" for generating keys for Linuxant HCF/HSF modem
drivers, are all hereby requested to ignore said email, save for the
purpose of its immediate removal, and take notice that the Linuxant
drivers are in fact covered by a non-GPL, commercial license.  Use of
that script would be illegal.


I still find myself deeply troubled and questioning the legalities of
using "GPL\0[...]" in the license string of a non-GPL module.  As it is
a blatant lie. =20

A string is used to represent ASCII characters, normally.  And this is
often data that is for human eligibility.  Said format of string storage
uses NULL, or \0, as a mark of termination of string. =20

Therefore such a string implies that the license *is* GPL.  Since
the /ONLY/ use of this variable is to mark the license type of the
module, it has been violated by this clear form of abuse.

My apologies to Linuxant for any troubles this misinterpretation of
their lie^H^H^Hhack may have caused.

--=20
Chad Christopher Giffin
mailto:typo@shaw.ca

There are 10 kinds of people in this world... those who understand
binary and those who do not.   -- Anonymous


--=-kNukLIvex/fOETd2ar+F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgjrbE11tuFHhP4oRAlgzAKCFp0H4HoAO1ABdGGAdcIhj8hsgqwCdF25P
ywzaOxyVzSJqCyAtvPEgamU=
=niLO
-----END PGP SIGNATURE-----

--=-kNukLIvex/fOETd2ar+F--

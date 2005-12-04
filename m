Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLDT6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLDT6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLDT6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:58:53 -0500
Received: from mout1.freenet.de ([194.97.50.132]:64967 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932328AbVLDT6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:58:52 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Feyd <feyd@seznam.cz>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Date: Sun, 4 Dec 2005 20:58:30 +0100
User-Agent: KMail/1.8.3
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051204205208.46e44480@epsilon.site>
In-Reply-To: <20051204205208.46e44480@epsilon.site>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1468819.B5KclmETAF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512042058.30801.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1468819.B5KclmETAF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 04 December 2005 20:52, you wrote:
> On Sun, 04 Dec 2005 19:50:08 +0100 (CET)
> mbuesch@freenet.de wrote:
>=20
> > I am writing this mail on my PowerBook and it is sent
> > wireless to my AP.
> > That means, we can transmit real data, if you did not get it, yet. :)
>=20
> Amazing progress :)
>=20
> > That does _not_ mean, that it completely works, yet.
> > The team is in the progress of writing a SoftwareMAC layer,
> > which is needed for the bcm device. The SoftMAC is still very
> > incomplete. So do not expect to do any fancy stuff like WPA
> > or something line that with it.
> > Please be patient, thanks. :)
>=20
> Why not use the new in-kernel wifi stack?=20

We do. The SoftMAC is an extension to it.
SoftMAC =3D Software Medium Access Control. It is about sending
and receiving management frames.
Some chips do this in hardware, so it is not part of the ieee80211 stack.
(the ipw2x00 do it in hardware, for example.)

PS: Sorry for the spam on the bottom of the previous mail. I had
to send it with the web-interface.

=2D-=20
Greetings Michael.

--nextPart1468819.B5KclmETAF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDk0pmlb09HEdWDKgRAiSnAJ9qxEOlsZnf6ekXmu/QhMpvm4v8RgCfTxsb
iLSipWGL3FXeAazKOWMho+s=
=LThQ
-----END PGP SIGNATURE-----

--nextPart1468819.B5KclmETAF--

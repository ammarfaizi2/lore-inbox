Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWADVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWADVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWADVE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:04:28 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:54497 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S932578AbWADVE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:04:27 -0500
Message-ID: <43BC40B5.90607@gorzow.mm.pl>
Date: Wed, 04 Jan 2006 22:40:05 +0100
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
User-Agent: Thunderbird 1.4.1 (X11/20051010)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] Re: 2.6.15-ck1
References: <200601041200.03593.kernel@kolivas.org>	<20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com> <1136406837.2839.67.camel@laptopd505.fenrus.org>
In-Reply-To: <1136406837.2839.67.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig778AA1715DD8343297C79A56"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig778AA1715DD8343297C79A56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arjan van de Ven wrote:
> On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
>
> sounds like we need some sort of profiler or benchmarker or at least a
> tool that helps finding out which timers are regularly firing, with the=

> aim at either grouping them or trying to reduce their disturbance in
> some form.
>=20

You mean something like a modification to timer debugging patch to
record the last time the timer fired, right?
Timertop could then detect the pattern and provide frequency, standard
deviation and other statistical data.
It would be much more expensive to test of course.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig778AA1715DD8343297C79A56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDvEC1lUMEU9HxC6IRAkOPAJ45nBbbt6qPsIKut3XyT3d/479j3ACgiXhn
G6hdUXW2kY2TZl5L9IV96Ok=
=Y1Yv
-----END PGP SIGNATURE-----

--------------enig778AA1715DD8343297C79A56--

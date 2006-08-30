Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWH3DdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWH3DdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 23:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWH3DdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 23:33:22 -0400
Received: from mail.ipom.com ([209.40.128.125]:45275 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S932424AbWH3DdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 23:33:22 -0400
Message-ID: <44F506FD.1000608@ipom.com>
Date: Tue, 29 Aug 2006 20:33:17 -0700
From: Phil Dibowitz <phil@ipom.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Rene Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] unusual device Sony Ericsson M600i
References: <200608290913.13875.rene@exactcode.de>
In-Reply-To: <200608290913.13875.rene@exactcode.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A56B1B69200931A11442551"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A56B1B69200931A11442551
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rene Rebe wrote:
> Hi,
>=20
> the Sony Ericsson M600i needs some overwrites to be accessed properly:

I actually applied a similar patch 2 days ago, but without the
IGNORE_RESIDUE, as that's not needed. You should see the entry in the nex=
t
kernel release.

Thank you though.
--=20
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't matte=
r
and those who matter don't mind."
 - Dr. Seuss



--------------enig9A56B1B69200931A11442551
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9Qb9N5XoxaHnMrsRAksaAJkBmeGmyK3MlZA49bBia3/mABhLqwCeOgz0
PMPWABZUdU4WWh0qu0AM95s=
=DCLR
-----END PGP SIGNATURE-----

--------------enig9A56B1B69200931A11442551--

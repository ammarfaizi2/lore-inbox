Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVAEU6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVAEU6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVAEU6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:58:34 -0500
Received: from 213-0-210-61.dialup.nuria.telefonica-data.net ([213.0.210.61]:19084
	"EHLO dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S262582AbVAEU5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:57:33 -0500
Date: Wed, 5 Jan 2005 21:57:31 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3-bk15 hanged under high load (i386)
Message-ID: <20050105205731.GA29637@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20050105183947.GA5601@localhost> <20050105190440.GA479@gates.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20050105190440.GA479@gates.of.nowhere>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday, 05 January 2005, at 20:04:40 +0100,
Jurriaan on adsl-gate wrote:

> Did you have memtest86 run some loops over your memory?
>=20
Yes, some time ago. I was having occasional lock-ups and suspected from
bad (or low quality) RAM, so I left memtest86 running for a day, and it
reported no problems at all. However, at this time I couln't find anything
in the logs.

Maybe it just another case of crappy hardware, that from time to time
seems to be more sensitive to load and starts giving errors more frequently.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.10-rc3-bk15)


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB3FS7ao1/w/yPYI0RAsmJAJ0WqWRVAs9wTaJ+8rfe9mTwh2q6GgCgm9/w
kCFWNKowFqgtP9t3xY5zYzI=
=9Zt6
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

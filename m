Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVAWMWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVAWMWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 07:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVAWMWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 07:22:47 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:17798 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261299AbVAWMWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 07:22:38 -0500
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a
	threading error
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, diego@pemas.net
In-Reply-To: <41F30E0A.9000100@osdl.org>
References: <217740000.1106412985@[10.10.2.4]>  <41F30E0A.9000100@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CefHPXlaThbu04l+fHKl"
Date: Sun, 23 Jan 2005 13:22:34 +0100
Message-Id: <1106482954.1256.2.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CefHPXlaThbu04l+fHKl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-22 at 18:38 -0800, Randy.Dunlap wrote:

> > Distribution: Debian
> > Hardware Environment: Pentum III 733 MHz
> > Software Environment: Debian Sid
> > Problem Description:
> > While starting open Office crashes, it did not happend on 2.6.10, but h=
append on
> > 2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If =
i go back
> > to 2.6.10 OpenOffice starts just fine.
>=20
> OO works for me on 2.6.11-rc2, but my OO is 1.1.1.
> The bugzilla mentions 1.1.2yyy and 1.1.3zzz, so I'd see if you
> (diego) can try some 1.1.3 OO.

OO in debian unstable, version 1.1.3-4 works just fine on 2.6.11-rc2
here

--=20
/Martin

--=-CefHPXlaThbu04l+fHKl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB85cKWm2vlfa207ERAk58AJ49aE55dztiD5IWe+6GD+ZTZibVcACcCWz6
y+7a+Vyw19/PVyo9xdVFpXU=
=6H8/
-----END PGP SIGNATURE-----

--=-CefHPXlaThbu04l+fHKl--

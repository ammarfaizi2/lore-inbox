Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWH1TLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWH1TLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWH1TLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:11:48 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:14246 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751350AbWH1TLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:11:47 -0400
Date: Mon, 28 Aug 2006 19:09:11 +0000
From: David Hollis <dhollis@davehollis.com>
Subject: Re: [PATCH] mcs7830: clean up use of kernel constants
In-reply-to: <200608272241.05026.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
Message-id: <1156792151.2699.8.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.7.92 (2.7.92-4.fc6)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-ipcfUTceK1wWdxQvIHYe"
References: <200608071500.55903.arnd.bergmann@de.ibm.com>
	<200608071811.09978.arnd.bergmann@de.ibm.com>
	<200608202207.39709.arnd@arndb.de>  <200608272241.05026.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ipcfUTceK1wWdxQvIHYe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-08-27 at 22:41 +0200, Arnd Bergmann wrote:
> This use the MII register constants provided
> by the kernel instead of hardcoding numerical
> values in the driver.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David Hollis <dhollis@davehollis.com>

--=20
David Hollis <dhollis@davehollis.com>

--=-ipcfUTceK1wWdxQvIHYe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQBE8z9XxasLqOyGHncRAvTmAJdPIXHUJvgHThy80b4NKwJpz14BAJ486wU/
JlTQlC3/zlsfZ4PIn5tHVw==
=Q+J1
-----END PGP SIGNATURE-----

--=-ipcfUTceK1wWdxQvIHYe--


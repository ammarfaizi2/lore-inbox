Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUHWH5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUHWH5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 03:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUHWH5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 03:57:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24969 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267478AbUHWH5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 03:57:21 -0400
Subject: Re: [PATCH] via-velocity: use common crc16 code for WOL
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408222213.i7MMDm57014913@hera.kernel.org>
References: <200408222213.i7MMDm57014913@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1f0C8PZWXVQvVIa7EeAh"
Organization: Red Hat UK
Message-Id: <1093247839.2792.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 09:57:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1f0C8PZWXVQvVIa7EeAh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-03 at 08:20, Linux Kernel Mailing List wrote:
> ChangeSet 1.1757.72.2, 2004/07/03 02:20:30-04:00, romieu@fr.zoreil.com
>=20
> 	[PATCH] via-velocity: use common crc16 code for WOL
> =09
> 	- use common crc16 code for WOL;
> 	- remove unused ether_crc.
> =09


ehhh my BK tree doesn't have linux/crc16.h ...

--=-1f0C8PZWXVQvVIa7EeAh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKaNfxULwo51rQBIRAujtAKClVRDIEI5hv0EA7Q8wWNhDofFL5QCfblzq
w9JG9Bij1fNR/IpOQS8Cn2k=
=UwFM
-----END PGP SIGNATURE-----

--=-1f0C8PZWXVQvVIa7EeAh--


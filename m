Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbTGOPSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268564AbTGOPPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:15:19 -0400
Received: from host81-136-144-97.in-addr.btopenworld.com ([81.136.144.97]:25581
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP id S268470AbTGOPMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:12:31 -0400
Subject: Re: [RFC][PATCH 0/5] relayfs
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, bob@watson.ibm.com
In-Reply-To: <16148.6807.578262.720332@gargle.gargle.HOWL>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X/eJnZlljnpKlwbA4Jnu"
Message-Id: <1058282847.375.3.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 15 Jul 2003 16:27:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X/eJnZlljnpKlwbA4Jnu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-15 at 16:15, Tom Zanussi wrote:
> The following 5 patches implement relayfs, adding a dynamic channel
> resizing capability to the previously posted version.
>=20
> relayfs is a filesystem designed to provide an efficient mechanism for
> tools and facilities to relay large amounts of data from kernel space
> to user space.  Full details can be found in Documentation/filesystems/
> relayfs.txt.  The current version can always be found at
> http://www.opersys.com/relayfs.

Could this be used to replace mmap() packet socket, how does it compare?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-X/eJnZlljnpKlwbA4Jnu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FB1fkbV2aYZGvn0RAolMAJ9O4qPMw3eanq59EkOmmQSBiGao0ACfbdWO
ipsB8Bj26Eo21Gvh/3R0saI=
=pMKW
-----END PGP SIGNATURE-----

--=-X/eJnZlljnpKlwbA4Jnu--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbSKATRe>; Fri, 1 Nov 2002 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSKATRd>; Fri, 1 Nov 2002 14:17:33 -0500
Received: from B5292.pppool.de ([213.7.82.146]:40586 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265696AbSKATRc>; Fri, 1 Nov 2002 14:17:32 -0500
Subject: ARP cache parameters?
From: Daniel Egger <degger@fhm.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-/eOLqg+2//36EkAc+oG4"
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Nov 2002 20:16:30 +0100
Message-Id: <1036178190.13261.7.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/eOLqg+2//36EkAc+oG4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

is there any good documentation around how to tweak Linux' arp caching
behaviour? I've been fooling around with parameters in=20
/proc/sys/net/ipv4/neigh/default but couldn't get it to keep hardware
addresses valid for a longer period of time than a few seconds.

I'd like to avoid caching hardware addresses in userspace and I need
my entries to be far longer reachable without making them permanent.

Any pointers would be greatly appreactiated.

--=20
Servus,
       Daniel

--=-/eOLqg+2//36EkAc+oG4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9wtMOchlzsq9KoIYRAr+hAKCWgbvpK03GCrwQO/Zm0n9sP/pXOACgvMfm
iVbx00LGGi67XRWWCslMQbI=
=yQtz
-----END PGP SIGNATURE-----

--=-/eOLqg+2//36EkAc+oG4--


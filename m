Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTAVEb6>; Tue, 21 Jan 2003 23:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTAVEb6>; Tue, 21 Jan 2003 23:31:58 -0500
Received: from evrtwa1-ar9-4-65-255-073.evrtwa1.dsl-verizon.net ([4.65.255.73]:32938
	"EHLO omgwallhack.org") by vger.kernel.org with ESMTP
	id <S267309AbTAVEb5>; Tue, 21 Jan 2003 23:31:57 -0500
From: chatos@omgwallhack.org (Jules Kongslie)
Date: Tue, 21 Jan 2003 20:40:43 -0800
To: linux-kernel@vger.kernel.org
Subject: Cryptoloop in Linux 2.5
Message-ID: <20030122044043.GA4408@omgwallhack.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I wondering about the status of encrypted loopback support in the 2.5
kernel series. I know crypto-api was merged in, but I haven't been able
to find any pointers about encrypting loopback devices, and I haven't
seen any pointers to this after searching.

It would also be nice to be able to apply encryption to a partition
directly, without a loopback, although I can see that this might require
a new set of ioctls and might introduce some incompatibilities.

Thanks,

-Jules Kongslie
<chatos@omgwallhack.org>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+LiDL+6o3+Z/zOlURAgAXAKC0a+EVE4Ld4r8f8l13K2FKJmFhBwCgkpAC
GgEgd0J7fQgQrDzQdKjOikY=
=0FW5
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

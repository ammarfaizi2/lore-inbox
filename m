Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTH2LmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTH2LmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:42:25 -0400
Received: from 82-38-50-143.cable.ubr04.brad.blueyonder.co.uk ([82.38.50.143]:44990
	"HELO prozac") by vger.kernel.org with SMTP id S264528AbTH2LmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:42:23 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xwb/Sp71lERVmuNxkVLi"
Message-Id: <1062157312.5020.18.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 29 Aug 2003 12:41:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xwb/Sp71lERVmuNxkVLi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-29 at 06:35, Jamie Lokier wrote:
> Dear All,
>=20
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.

PPC (G4).

Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

cpu             : 7455, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 665.19
machine         : PowerBook3,4
motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
board revision  : 00000000
detected as     : 73 (PowerBook Titanium III)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-Xwb/Sp71lERVmuNxkVLi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Tzv/kbV2aYZGvn0RApl8AJ9KCrUZqGlrLbZ3IWM9Z5glTA6PNwCfTKo8
OfL8OUh/MYDsH9KDQJmMSFg=
=zf9u
-----END PGP SIGNATURE-----

--=-Xwb/Sp71lERVmuNxkVLi--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130911AbQKXOT2>; Fri, 24 Nov 2000 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130765AbQKXOTT>; Fri, 24 Nov 2000 09:19:19 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:23556 "EHLO
        orbita.don.sitek.net") by vger.kernel.org with ESMTP
        id <S130766AbQKXNeH>; Fri, 24 Nov 2000 08:34:07 -0500
Date: Fri, 24 Nov 2000 16:05:53 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI interpreter on ACPItableless systems
Message-ID: <20001124160553.C3900@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

this patch makes ACPI poweroff possible on ACPI capable systems without=20
BIOS provided ACPI tables.
I sent this patch to LKML some month ago, but didn't get an answer :(

I will be out of this list for some weeks, so happy hacking and good bye,
	    Andrey

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6HmexBm4rlNOo3YgRAmIjAJwNxscjYCPTHgAaqy63e431q++elwCeLOoW
KoaVi9Rw0J6E957tVFDaKXI=
=C79V
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

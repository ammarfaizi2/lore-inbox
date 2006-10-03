Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWJCW2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWJCW2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWJCW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:28:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37017 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030485AbWJCW2h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:28:37 -0400
Message-Id: <200610032228.k93MSOhn015311@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
In-Reply-To: Your message of "Tue, 03 Oct 2006 14:59:54 PDT."
             <20061003145954.06b2aa49@freekitty>
From: Valdis.Kletnieks@vt.edu
References: <1df1788c0610031425p4f1ca206teb05590a91eb7659@mail.gmail.com> <198AC4CE-A2CC-41DB-8D53-BDFB7959781B@mac.com>
            <20061003145954.06b2aa49@freekitty>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159914504_6282P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 18:28:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159914504_6282P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Oct 2006 14:59:54 PDT, Stephen Hemminger said:

> I looked at it, basically his argument which is all flowered up in pret=
ty
> pictures and security vulnerability language is:
>=20
>    If root loads a buggy module then the module can be used to compromi=
se
>    the system.
>=20
> Well isn't that surprising.

Big yawner.  Now if the claim had been that a properly buggy module, inse=
rted
under a certain set of circumstances, got onto the binfmt list *even when=
 the
process loading it wasn't root*, now *that* would be an exploit....

--==_Exmh_1159914504_6282P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIuQIcC3lWbTT17ARAv0CAKCFFVbyow8bK1SDpev8V5Yiw5SFrgCgtZOn
pOO92agdQNQ7BMKYWNNn9IA=
=mEq5
-----END PGP SIGNATURE-----

--==_Exmh_1159914504_6282P--

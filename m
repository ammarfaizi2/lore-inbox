Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTBYKDS>; Tue, 25 Feb 2003 05:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBYKDS>; Tue, 25 Feb 2003 05:03:18 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26863 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267881AbTBYKDR>; Tue, 25 Feb 2003 05:03:17 -0500
Subject: Re: kernel -2.4.18
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Fernando R Secco <TByteP@netscape.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E5AB69B.5020907@netscape.net>
References: <3E5AB69B.5020907@netscape.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SlQAuGtT1onVo3w/LWzW"
Organization: 
Message-Id: <1046168007.1523.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 25 Feb 2003 11:13:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SlQAuGtT1onVo3w/LWzW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-25 at 01:19, Fernando R Secco wrote:
> mmap
> forget_pte: old mapping existed!
> ------------[ cut here ]------------
> kernel BUG at memory.c:314!
> invalid operand: 0000
> driver_myrinet nls_iso8859-1 cmpci soundcore ide-cd cdrom agpgart nvidia=20

thank you for using nvidia and driver_myrinet. please report this bug to
either of the vendors of these modules instead, the driver_myrinet seems
to be the cause of this one.


--=-SlQAuGtT1onVo3w/LWzW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+W0HHxULwo51rQBIRAhcMAJ9JLBwOAVoCpCY4ATaqxcxLN2xspgCgiRhj
AEGzbs2zc+lUsHkz0sb8G9Y=
=utce
-----END PGP SIGNATURE-----

--=-SlQAuGtT1onVo3w/LWzW--

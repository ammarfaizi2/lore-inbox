Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSKNO5m>; Thu, 14 Nov 2002 09:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSKNO5m>; Thu, 14 Nov 2002 09:57:42 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:3339 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264903AbSKNO5l>;
	Thu, 14 Nov 2002 09:57:41 -0500
Date: Thu, 14 Nov 2002 18:03:42 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4
Message-ID: <20021114150325.GA313@pazke.ipt>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20021114032456.3337E2C057@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20021114032456.3337E2C057@lists.samba.org>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A7=D1=82=D0=B2, =D0=9D=D0=BE=D1=8F 14, 2002 at 03:23:00 +1100, Rusty=
 Russell wrote:
> Types "short", "ushort", "int", "ulong", "bool", "invbool" etc are
> implemented pre-canned.  You can define your own, see linux/params.h
> for how.
Why not u8, u16, u32 etc ?

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE907tOBm4rlNOo3YgRAliQAKCLLqje2bWKCXb7mtQqC/cmHYASxACfQZki
sHPxXun5YktkGbVRfshnfLU=
=9kvx
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

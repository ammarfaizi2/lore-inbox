Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSKRRbr>; Mon, 18 Nov 2002 12:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRRbr>; Mon, 18 Nov 2002 12:31:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2804 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263256AbSKRRbq>;
	Mon, 18 Nov 2002 12:31:46 -0500
Subject: Re: LTP - gettimeofday02 FAIL
From: Paul Larson <plars@linuxtestproject.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021114215209.GA25778@tapu.f00f.org>
References: <1037139074.10626.37.camel@plars> 
	<20021114215209.GA25778@tapu.f00f.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-giZvfdJ6DCDDzww8Yu3I"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Nov 2002 11:34:04 -0600
Message-Id: <1037640849.21245.0.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-giZvfdJ6DCDDzww8Yu3I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-11-14 at 15:52, Chris Wedgwood wrote:
> The TSC's aren't synchronized between CPUs.
>=20
> This is becoming more and more of a problem and in-escapable on some
> hardware so I'm starting to wonder if assuming the TSCs are even
> roughly synchronized *anywhere* is a good idea.

So this is a hardware issue? no way around this?

-Paul Larson

--=-giZvfdJ6DCDDzww8Yu3I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3ZJIwACgkQbkpggQiFDqeaogCeIJ6L/2/N1C30M/TcsBo2bJq0
8nMAn3XMBQhKoHATPlKYMzo9sCkyZIba
=NY6Y
-----END PGP SIGNATURE-----

--=-giZvfdJ6DCDDzww8Yu3I--


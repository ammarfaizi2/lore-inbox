Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUE0Lxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUE0Lxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUE0Lxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:53:34 -0400
Received: from mail.donpac.ru ([80.254.111.2]:26267 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261993AbUE0Lx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:53:28 -0400
Date: Thu, 27 May 2004 15:53:27 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
Message-ID: <20040527115327.GA7499@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040527015259.3525cbbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20040527015259.3525cbbc.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 148, 05 27, 2004 at 01:52:59 -0700, Andrew Morton wrote:
>
> +make-proliant-8500-boot-with-26.patch
>=20
>  Fix hpaq proliant 8500

Ugh, dmi_scan.c changed again ... :(

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtda3by9O0+A2ZecRArSAAJ9d4UhV4bpvjxfbZEKxetW9DsYcSACgxjVH
WWEKWFcch/179yqo+BtK39w=
=Krjz
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

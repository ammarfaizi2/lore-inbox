Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTENN6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTENN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:57:54 -0400
Received: from adsl-65-64-153-5.dsl.stlsmo.swbell.net ([65.64.153.5]:10463
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id S262306AbTENN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:56:46 -0400
Subject: Re: Compile error including asm/uaccess.h
From: Stephen Torri <storri@sbcglobal.net>
To: ismail donmez <kde@smtp-send.myrealbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1052919428.273b9220kde@smtp-send.myrealbox.com>
References: <1052919428.273b9220kde@smtp-send.myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3QQmVncLC/AqXEc5aqEs"
Organization: 
Message-Id: <1052921988.25317.3.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 14 May 2003 09:19:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3QQmVncLC/AqXEc5aqEs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Dont include kernel headers in userspace OR define the needed variables t=
o  make your userspace application compile.
>=20
> Nice report btw=20
>=20
> /ismail

How then do you wrote an application to utilize kernel features? I am
working on a real-time operating system (KURT - www.ittc.ku.edu/kurt)
and need to include a header that exists in the kernel. The header is
installed in the /usr/src/linux/include/linux/ but not in
/usr/include/linux.

Thanks about the report. I got the idea from a library I help work on
called ACE+TAO (www.cs.wustl.edu/~schmidt/ACE.html).

Stephen
--=20
Stephen Torri <storri@sbcglobal.net>

--=-3QQmVncLC/AqXEc5aqEs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+wlCEmXRzpT81NcgRAtWBAKC15Asqi5IRHZtsmvZZ229KiB26kACeJuIR
ySmOz7YzdAzfGa5iiIpNaG0=
=FZZb
-----END PGP SIGNATURE-----

--=-3QQmVncLC/AqXEc5aqEs--


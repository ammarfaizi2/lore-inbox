Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLWQPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLWQPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:15:03 -0500
Received: from hostmaster.org ([80.110.173.103]:62859 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S261898AbTLWQO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:14:57 -0500
Subject: 2.6.0/menuconfig->help
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4GIcf4EPvNLWOamF+Y44"
Message-Id: <1072196085.1433.15.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 17:14:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4GIcf4EPvNLWOamF+Y44
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I guess it is quite common that /usr/src/linux is owned by root and mode
u=3DrwX,go=3DrX. For me it is also desirable that any unprivileged user can
view the kernel configuration by calling *config. This basically works
but viewing the description/help for a configuration option fails with
menuconfig.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

Error reading FAT record: Try the SKINNY one? (Y/N)

--=-4GIcf4EPvNLWOamF+Y44
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAP+hp72D1OYqW/8uJAQKMuQf/ccffAeNsq+bRAkB6lhstCNU8x+7q3wGE
OORgfyGzAc/Nb2ulU3YuzD8PS7PnOOczlyLtIF3+cFZOOvO+DKH2SmdQOV+vgaBX
mYT31U/+3aMCe7gKpSRPMqPzPb+aisTQEh9cIW50G0gQ5dzNcSl5pBzxtSSosmkQ
Tu2/l5VSrNhe3kLwl1wGP6ZBbfFcNgAhAG5+59DTDOKWqvlsCT2oVh6LzYqZ0pjG
oyz1hqEyhl9fIKYZzkwWpKBBx9hmETQAutHuZWp5mgDimGlSMk6w8uf9Rctr6k3A
pcuMeoch6BOSunWCnVJrQUeeTpNmuTQxpTa9bvYxcKMPqS2WeRpjPQ==
=nwgi
-----END PGP SIGNATURE-----

--=-4GIcf4EPvNLWOamF+Y44--


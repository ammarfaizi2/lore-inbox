Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUAOIu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUAOIu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:50:57 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:54467 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S266361AbUAOIuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:50:55 -0500
Date: Thu, 15 Jan 2004 09:50:52 +0100
From: martin f krafft <madduck@madduck.net>
To: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-ID: <20040115085052.GA28057@piper.madduck.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113215355.GA3882@piper.madduck.net> <20040113143053.1c44b97d.rddunlap@osdl.org> <20040113223739.GA6268@piper.madduck.net> <20040113144141.1d695c3d.rddunlap@osdl.org> <20040113225047.GA6891@piper.madduck.net> <20040113150319.1e309dcb.rddunlap@osdl.org> <3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com> <20040114154836.35614a92.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20040114154836.35614a92.rddunlap@osdl.org>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Randy.Dunlap <rddunlap@osdl.org> [2004.01.15.0048 +0100]:
> > kernel: request_module: failed /sbin/modprobe -- digest_null. error =3D=
 256
>=20
> Chris Wright tells me that this is a null digest crypto plugin
> for testing.  It might show up in your /etc/modprobe.conf file
> (or it might not).

i don't see such a module in the kernel config. there is the null
encryption, but it's not a null digest.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
this space intentionally left blank.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABlRsIgvIgzMMSnURAmSrAJ9lRc7Rq144X0Q5Hmeje6XEXfLCAwCgwCeH
q6hlIndBaBJK/5nL5P/pJ8U=
=HbbA
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

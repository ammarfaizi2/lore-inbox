Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUAMVyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUAMVyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:54:06 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:16785 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265800AbUAMVyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:54:01 -0500
Date: Tue, 13 Jan 2004 22:53:55 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: modprobe failed: digest_null
Message-ID: <20040113215355.GA3882@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am seeing many messages like

  kernel: request_module: failed /sbin/modprobe -- digest_null. error =3D 2=
56

in my logs. What's the nature of these?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"it's time for the human race to enter the solar system."=20
                                                      - george w. bush

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABGjzIgvIgzMMSnURAh2+AJ9surxD8B0VpBxwYIlQNYEBpKJ6fQCgmsem
oJ+w8okelZzkuaTogLx2vXU=
=Qb+8
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

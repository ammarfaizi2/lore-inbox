Return-Path: <linux-kernel-owner+w=401wt.eu-S1751999AbWLNXzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWLNXzx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWLNXzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:55:53 -0500
Received: from mx.laposte.net ([81.255.54.11]:10786 "EHLO mx.laposte.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbWLNXzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:55:52 -0500
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:55:52 EST
Subject: Re: Linux 2.6.20-rc1
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4581DCA4.2010800@garzik.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	 <200612141930.19797.s0348365@sms.ed.ac.uk>
	 <loom.20061214T213058-9@post.gmane.org>  <4581DCA4.2010800@garzik.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oOPT5JGoVXCsf196dvI7"
Organization: Adresse perso
Date: Fri, 15 Dec 2006 00:33:59 +0100
Message-Id: <1166139239.32306.4.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-3.fc7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oOPT5JGoVXCsf196dvI7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le jeudi 14 d=C3=A9cembre 2006 =C3=A0 18:22 -0500, Jeff Garzik a =C3=A9crit=
 :
> Nicolas Mailhot wrote:
> > Alistair John Strachan <s0348365 <at> sms.ed.ac.uk> writes:
> >=20
> >> `hddtemp' has stopped working on 2.6.20-rc1:
> >=20
> > =E2=86=92 http://bugzilla.kernel.org/show_bug.cgi?id=3D7581
>=20
> I'm not sure I quite follow your bug report.  Are you saying that the=20
> patch you attached causes the problem?

No, I'm saying the hddtemp breakage people report against 2.6.20-rc1
also occurred between 2.6.19-rc5-mm2 and 2.6.19-rc6-mm1, as reported in
this bug.

Also this system sports two different (S)ATA controllers (SiI 3114 and
CK804), disks on both stopped reporting temp at the same time so the
change is not chipset-specific

--=20
Nicolas Mailhot

--=-oOPT5JGoVXCsf196dvI7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEABECAAYFAkWB32cACgkQI2bVKDsp8g1rcgCgv1U4Gxhx3UHwLur+EatDSA16
zMEAoMN4/8U1ofmjSswu7KxP7Tx936tG
=TXcW
-----END PGP SIGNATURE-----

--=-oOPT5JGoVXCsf196dvI7--

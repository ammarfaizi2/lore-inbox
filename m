Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTLEGbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLEGbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:31:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26830 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263596AbTLEGbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:31:51 -0500
Date: Fri, 05 Dec 2003 01:31:50 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: High-pitch noise with 2.6.0-test11
To: linux-kernel@vger.kernel.org
Message-id: <1070605910.4867.9.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-GxcOy8wv4NBAB6wAssYw";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GxcOy8wv4NBAB6wAssYw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I just installed 2.6.0-test11 on my Dell Latitude D600 (Pentium-M)
laptop and I noticed a strange high-pitch noise comming from the laptop
itself (that wasn't there with 2.4). The noise happens only when the CPU
is idle. Also, I have noticed that removing thermal.o makes the noise
stop, which is very odd. Is there anything that can be done about that?

Another (unrelated) problem I noticed is the fact that since I upgraded
to 2.6, X started behaving strangely wrt left-click copy and
middle-click paste. Any idea what the cause can be? I'm using Fedora
Core 1.

Thanks,

	Jean-Marc

P.S. Please CC to me, since I'm not subscribed

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-GxcOy8wv4NBAB6wAssYw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0CZVdXwABdFiRMQRAvKVAKC8kBjoBudgry+CcLf2FNJjni2hkgCdGN9Z
Gsiiqbk1pIjvjtsv8CvuI5Y=
=yiza
-----END PGP SIGNATURE-----

--=-GxcOy8wv4NBAB6wAssYw--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTLEPRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTLEPR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:17:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24215 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S264132AbTLEPR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:17:28 -0500
Date: Fri, 05 Dec 2003 10:16:33 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Double-click on touchpad
In-reply-to: <20031205093200.GA8877@nasledov.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1070637392.12400.1.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-wt3WBUBhQ+jVOKQ4pqbS";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1070610304.4328.14.camel@idefix.homelinux.org>
 <20031205093200.GA8877@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wt3WBUBhQ+jVOKQ4pqbS
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Le ven 05/12/2003 =E0 04:32, Misha Nasledov a =E9crit :
> Do you have both /dev/psaux and /dev/input/mice in your XF86Config file? =
In
> 2.6, these are the same thing, so it actually opens the same mouse twice =
and
> it can cause such weird issues with it.

OK, I removed /dev/input/mice and it now behaves correctly. Now I'm just
not sure how I can add a secondary USB mouse in these conditions...

Thanks,

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-wt3WBUBhQ+jVOKQ4pqbS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0KFQdXwABdFiRMQRAqWDAKCPyTnadaoNWSVSZwkKM/+jFFufIACfb0nh
kkarS+enXgJ0njGXJRA/uls=
=epW9
-----END PGP SIGNATURE-----

--=-wt3WBUBhQ+jVOKQ4pqbS--


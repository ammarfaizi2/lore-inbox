Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUAFIYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUAFIYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:24:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10598 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S261492AbUAFIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:23:59 -0500
Date: Tue, 06 Jan 2004 03:23:13 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
In-reply-to: <1073370806.2687.18.camel@mentor.gurulabs.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       "Yu, Luming" <luming.yu@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@intel.com
Message-id: <1073377393.3910.0.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-jg+bYjuNul9oAetcObKt";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073354003.4101.11.camel@idefix.homelinux.org>
 <20040105180859.7e20e87a.akpm@osdl.org>
 <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
 <1073370806.2687.18.camel@mentor.gurulabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jg+bYjuNul9oAetcObKt
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> > As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show=
_bug.cgi?id=3D1766
> > is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:
>=20
> Just confirming that the same patched fixed up the battery reporting
> problems on my laptop as well.

Works for me too. Case closed?

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-jg+bYjuNul9oAetcObKt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+nBwdXwABdFiRMQRArUuAKCxPhzvzSMEDy0g4BqpwScFcGarTACggfsW
a2FnjjXMc4lFVok9ZEWvEcY=
=Uqsj
-----END PGP SIGNATURE-----

--=-jg+bYjuNul9oAetcObKt--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTLETJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTLETJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:09:36 -0500
Received: from courrier3.usherbrooke.ca ([132.210.13.19]:57825 "EHLO
	courrier3.usherbrooke.ca") by vger.kernel.org with ESMTP
	id S264332AbTLETJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:09:32 -0500
Subject: RE: High-pitch noise with 2.6.0-test11
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Troels Walsted Hansen <troels@thule.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C93186@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84702C93186@orsmsx401.jf.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3Kaf//g8ujFKFCAB47dW"
Organization: Universite de Sherbrooke
Message-Id: <1070651354.4204.1.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Dec 2003 14:09:14 -0500
X-UdeS-MailScanner-Information: Veuillez consulter le http://www.usherbrooke.ca/vers/virus-courriel
X-UdeS-MailScanner: Aucun code suspect =?ISO-8859-1?Q?d=E9tect=E9?=
X-MailScanner-SpamCheck: n'est pas un polluriel, SpamAssassin (score=-4.9,
	requis 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3Kaf//g8ujFKFCAB47dW
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Here's the answer from another thread:
>=20
> "It's not normal, but it means they used cheap capacitors. This is known
> as the acoustic noise issue. It's related to PCB vibration as a result
> of the piezo electric effect on the caps. What is the timer tick
> frequency? ... The 1ms gives a nice 1kHz tone. It's related to the
> voltage change of C4 exit."

Well, that still doesn't explain why the noise is only there when I
insert thermal.o. Also, the noise seems to be higher than 1 kHz (I'd
guess 5-10 kHz).

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-3Kaf//g8ujFKFCAB47dW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0NfYdXwABdFiRMQRAvbfAJ9im2OvjURcvxolDMR3enxYHmKbowCcCPe8
RslqP3adGArtsWDrHlFVjHM=
=8Ar0
-----END PGP SIGNATURE-----

--=-3Kaf//g8ujFKFCAB47dW--


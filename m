Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267665AbTACVLA>; Fri, 3 Jan 2003 16:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbTACVLA>; Fri, 3 Jan 2003 16:11:00 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:13808 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267665AbTACVK6>; Fri, 3 Jan 2003 16:10:58 -0500
Subject: Re: Gigabit/SMP performance problem
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Avery Fay <avery_fay@symantec.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>
References: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WFMiPXs7HlgO3C+Un5H+"
Organization: Red Hat, Inc.
Message-Id: <1041628746.1337.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Jan 2003 22:19:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WFMiPXs7HlgO3C+Un5H+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-01-03 at 21:25, Avery Fay wrote:

> Should I get rid of IRQ load balancing? And what do you mean "Intel broke=
 the P4's interrupt routing"?

well you can bind IRQ's to specific cpu's in /proc....


--=-WFMiPXs7HlgO3C+Un5H+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Ff5KxULwo51rQBIRAvR6AKCWOT7K/7v9CUvhrLLN9O1CeK2H4ACgpuiP
fQidERhjLzrdT2gAdQ45CBU=
=dbWH
-----END PGP SIGNATURE-----

--=-WFMiPXs7HlgO3C+Un5H+--

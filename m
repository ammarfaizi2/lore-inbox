Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbULMMtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbULMMtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbULMMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:49:18 -0500
Received: from macedonia.mhl.tuc.gr ([147.27.3.60]:26815 "HELO
	macedonia.mhl.tuc.gr") by vger.kernel.org with SMTP id S262246AbULMMsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:48:52 -0500
Subject: Re: PCI interrupt lost
From: Dimitris Lampridis <labis@mhl.tuc.gr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lkB8L3PWTk+xC/ECooic"
Date: Mon, 13 Dec 2004 14:48:49 +0200
Message-Id: <1102942129.3415.18.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lkB8L3PWTk+xC/ECooic
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I forgot to ask a final thing:
What is the proper way of configuring my INT pin on the Host Controller?
I can choose:
level/edge triggered
high/low   active
I've been told that PCI interrupts are level trig. active low. Is this
true? I've seen another driver initialize to level trig. active high!
(not that I haven't tried all the 4 cases anyway...)

Thanx again,
--=20
Dimitris Lampridis <labis@mhl.tuc.gr>

--=-lkB8L3PWTk+xC/ECooic
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBvY+vgMArLfy6HHMRAs9CAJ91Ew0SbdfNWLkb+fV6agR17naPwACfRRGN
9N4ACiIfpGaJb2yWbDSADcY=
=14CJ
-----END PGP SIGNATURE-----

--=-lkB8L3PWTk+xC/ECooic--


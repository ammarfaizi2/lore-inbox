Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbTCJWLQ>; Mon, 10 Mar 2003 17:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbTCJWLP>; Mon, 10 Mar 2003 17:11:15 -0500
Received: from B57c2.pppool.de ([213.7.87.194]:41196 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261496AbTCJWLN>; Mon, 10 Mar 2003 17:11:13 -0500
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
From: Daniel Egger <degger@fhm.edu>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200303102133.25790.hpj@urpla.net>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	 <m1adg4kbjn.fsf@frodo.biederman.org> <1047219550.4102.6.camel@sonja>
	 <200303102133.25790.hpj@urpla.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wLJ48bSqAE8V6gyKJ6By"
Organization: 
Message-Id: <1047333777.28220.79.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 23:02:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wLJ48bSqAE8V6gyKJ6By
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-03-10 um 21.33 schrieb Hans-Peter Jansen:

> The biggest bootimage I'm using here is (SuSE 8.2b3 Inst. Kernel+initrd):
> -r--r--r--    1 nobody   nogroup   6009856 Mar  6 10:07 bootimage-ziggy
> created with mknbi-linux V1.2, so this isn't really the problem.
> I'm also using ~4MB sized dos boot images (PQMagic, BIOS updates) without
> problems. Don't try this with floppies...

> Etherboot is simply pure fun and saved my life a couple of timesm ;-)

Hrm, as it turned out I had my scripts pointing to the netboot version
of mknbi (I remember vaguely having troubles with the etherboot version
back when I started netbooting) which seems to be somewhat limited.

A short test with the 1.2 version of the etherboot mknbi-linux worked as
expected, YAY! Now back to the try to boot a working 2.5 kernel. :)

Thanks for your help!

--=20
Servus,
       Daniel

--=-wLJ48bSqAE8V6gyKJ6By
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+bQuQchlzsq9KoIYRAvhwAKCTMbyLM/gNB84W1oXHYqx9DD94PACfS6+U
eBKW7k7YSC16sJt9+fksxPI=
=kEqY
-----END PGP SIGNATURE-----

--=-wLJ48bSqAE8V6gyKJ6By--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUEMUJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUEMUJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUEMUGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:06:49 -0400
Received: from cable220a221.usuarios.retecal.es ([212.183.220.221]:18304 "EHLO
	debian") by vger.kernel.org with ESMTP id S264738AbUEMTxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:53:00 -0400
Date: Thu, 13 May 2004 21:52:50 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: Eric Valette <eric.valette@free.fr>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2 : suddent lost of keyboard. Everything else OK.
Message-ID: <20040513195250.GA3303@debian>
References: <40A3C951.9000501@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <40A3C951.9000501@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El jue, 13 de may de 2004, a las 09:15:29 +0200, Eric Valette dijo:

> I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard.=
=20
> Everything else is working, I can rlogin, shutdown the system. It also
> happens in console mode and looks like either keyboard irq or more=20
> likely its post processing just do not process queued characters.

In my system this is happening when I press the "caps lock" key.

> I have nothing in dmesg nor in syslog. Attached in my .config.

The same here.

--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>       =20
jabber ID               <rreylinux at jabber dot org>
GPG public key ID       0xBEBD71D5 -> http://pgp.escomposlinux.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ranty, te echar=E9 de menos. - Ranty, I'll miss you.
http://roncero.org/blog/varios/erconde-ranty
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo9ISRGk68b69cdURAgLLAJ9znPwXAkXjvlHDSCelD9qm1sFXPgCghh0O
ABFEM9MgsIafJeHKODzS6Xw=
=rItJ
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

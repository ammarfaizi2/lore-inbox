Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSATXFZ>; Sun, 20 Jan 2002 18:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSATXFP>; Sun, 20 Jan 2002 18:05:15 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:22151 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S288733AbSATXFG>; Sun, 20 Jan 2002 18:05:06 -0500
Date: Sun, 20 Jan 2002 18:04:59 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb-ohci, ov511, video4linux
Message-ID: <20020120230459.GN2873@online.fr>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020120154119.GB2873@online.fr> <20020120162258.GC16166@sliepen.warande.net> <20020120170837.GD2873@online.fr> <20020120225423.GA27088@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20020120225423.GA27088@kroah.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 20, 2002 at 02:54:23PM -0800, Greg KH wrote:
> On Sun, Jan 20, 2002 at 12:08:37PM -0500, christophe barb=E9 wrote:
> >=20
> > The problem with the usb mouse is there with or without webcam.
>=20
> Is there any kernel log messages when the mouse "goes away"?
> It could be a flaky hub that is dropping the connection to your device,
> or a flaky mouse.  I've seen both of these before.

I see the mouse problem without hub.
So it could be a flaky mouse.
Is the fact that 'switching to the console and switching back to X
restore X' compatible with your idea ?

What sounds strange is that this appears only when CPU is mainly used by
others apps.

My idea is a timeout in X (without output : strange) due to a latency.

An important point here is that the mouse works fine with the 2.2 kernel
(I should have used 2.2.17 to 2.2.19).

Christophe

>=20
> thanks,
>=20
> greg k-h

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

A qui sait comprendre, peu de mots suffisent.
(Intelligenti pauca.)=20

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8S00bj0UvHtcstB4RAlFZAKCe4pDxMnR9DJPVBkwASATLhF+DVwCeLa8h
C2jD9BWr4SMTWBzF5Vcg3IY=
=V2pN
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--

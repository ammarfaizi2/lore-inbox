Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271254AbTGPXOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTGPXOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:14:43 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:53903 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271254AbTGPXOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:14:40 -0400
Date: Wed, 16 Jul 2003 19:29:33 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030716232933.GQ2412@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net> <20030717011008.A32081@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline
In-Reply-To: <20030717011008.A32081@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



/dev/sound/dsp doesn't exist.  I have devfsd installed and running
already.

Thus spake Rudo Thomas (thomr9am@ss1000.ms.mff.cuni.cz):

> > [snip] I just tried to load the emu10k1 which loads without error, but =
mpg123
> > says it can't open the default sound device.
>=20
> If the module loaded up properly, problem may be in mpg123. If you are us=
ing
> devfs, try mpg123 -a /dev/sound/dsp . If that works, set up devfsd.
>=20
> Rudo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Fd/d8+1vMONE2jsRAmbMAKCB7nPr06sbYPf0At3b357z2FdxMACgnPSi
gm6hAwwb3LzFKH/UQo4QK9A=
=dgro
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753529AbWKFRc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbWKFRc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbWKFRc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:32:28 -0500
Received: from nsm.pl ([195.34.211.229]:20413 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1753529AbWKFRc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:32:28 -0500
Date: Mon, 6 Nov 2006 18:32:11 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106173211.GA8512@irc.pl>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061106132903.GA25257@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20061106132903.GA25257@khazad-dum.debian.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2006 at 11:29:03AM -0200, Henrique de Moraes Holschuh wrote:
> > > > There is a bug here in that acpiphp shouldn't even be used on the X=
60 -
> > > > it has no hotpluggable slots.
>=20
> What about the internal mini PCI express slots (where the Intel 3945ABG
> device and EVDO wwwan cards are plugged)?

  EVDO is connected to USB. At least it works with usb-serial (after
manually binding IDs). Works =3D=3D responds to Hayes commands, I didn't
tried with SIM Card yet.

--=20
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuri=
ev


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFT3Gb10UJr+75NrkRAq29AJ99+fd/haEAOeRQtMeLt9bNlf+3xwCffuyn
sM0gG6SJC4U4No6tkVwAzto=
=32SB
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUAGHiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUAGHiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:38:21 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:57289 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266150AbUAGHiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:38:18 -0500
Date: Wed, 7 Jan 2004 08:38:12 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Card Intel Pro100
Message-ID: <20040107073812.GL14285@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <BEAEEFBEGJLPJJAA@mailcity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkzoT2Bc9VsM/9ev"
Content-Disposition: inline
In-Reply-To: <BEAEEFBEGJLPJJAA@mailcity.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkzoT2Bc9VsM/9ev
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-06 15:58:57 -0500, Sumit Narayan <sumit_uconn@lycos.com>
wrote in message <BEAEEFBEGJLPJJAA@mailcity.com>:
> Hi...
>=20
> I have loaded the new kernel 2.6.0, but my Ethernet card is not working o=
n it. Its Intel Ether Pro 100B. Could someone help me out with it. Its work=
ing perfectly fine with 2.4.21. Is there any special setting to be made for=
 the new kernel? I have used module-init-tools-0.9.14 to install the module=
s.

Additionally, I've seen hangs with eepro100 with some chipset-buildin
eepro100 variants in newer Intel chipsets. The e100 driver (provided by
Intel, but already included in Linux' sources) seems to work around some
chipset bugs...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--vkzoT2Bc9VsM/9ev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+7dkHb1edYOZ4bsRAiBqAJwPmaL0kZRjLLJOjLQr2vqSwK8Z3gCgjaU9
HLvr/OP5yUi9kzk0PDs25iA=
=C6Zr
-----END PGP SIGNATURE-----

--vkzoT2Bc9VsM/9ev--

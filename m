Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272845AbTG3MLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272848AbTG3MLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:11:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:63148 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272845AbTG3MLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:11:31 -0400
Date: Wed, 30 Jul 2003 14:11:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: bug alpha configure linux-2.6.0-test1
Message-ID: <20030730121130.GW1873@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200307291544.h6TFicBV004820@indianer.linux-kernel.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7uidztUHYC105IRM"
Content-Disposition: inline
In-Reply-To: <200307291544.h6TFicBV004820@indianer.linux-kernel.at>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7uidztUHYC105IRM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-29 17:46:05 +0200, Oliver Pitzeier <oliver@linux-kernel.at>
wrote in message <200307291544.h6TFicBV004820@indianer.linux-kernel.at>:
> Hi Walter!
> > arch/alpha/defconfig:244: trying to assign nonexistent symbol=20
> > SCSI_NCR53C8XX
>=20
> You are still hanging around with -test1? :) Give -test2 a try! It runs's=
 great for me, but -test1 did also... But we talk about this already...

-test1 didn't compile for me (asm/local.h missing IIRC), but indeed,
-test2 works quite well on my NoName.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--7uidztUHYC105IRM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J7XyHb1edYOZ4bsRAiH8AJ9qa2GZ0MEf3BIPXFubi4NjJnEfTACgiJe3
56tSZIVdUcNwulIaD6HFYdI=
=6IlX
-----END PGP SIGNATURE-----

--7uidztUHYC105IRM--

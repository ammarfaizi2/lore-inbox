Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTIAOL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIAOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:11:28 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:8838 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262913AbTIAOLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:11:23 -0400
Date: Mon, 1 Sep 2003 16:11:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: pl2303 + uhci oops
Message-ID: <20030901141122.GB14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200309011400.08914.biker@villagepeople.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <200309011400.08914.biker@villagepeople.it>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 14:00:08 +0200, biker@villagepeople.it <biker@villagepeo=
ple.it>
wrote in message <200309011400.08914.biker@villagepeople.it>:
> Using a pl2303-based usb->serial adaptor with the uhci driver always ends=
 with=20
> a oops.

Use 2.6.0-testX - it's fixed there:) I'm successfully using a GPS
receiver based on a pl2303. This one if from www.lact.de (ebay'ed).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/U1OJHb1edYOZ4bsRAib5AKCOb7Ox/xHlSbtUYhfzGAwxGVFYwACfWzsC
2I+kLEeP1G0uVLL7nO42vNA=
=1fdf
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265056AbUFRJZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUFRJZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUFRJYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:24:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:65230 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265056AbUFRJTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:19:07 -0400
Date: Fri, 18 Jun 2004 11:19:06 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/11] serio allow rebinding
Message-ID: <20040618091905.GW20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200406180335.52843.dtor_core@ameritech.net> <200406180341.39441.dtor_core@ameritech.net> <200406180342.11056.dtor_core@ameritech.net> <200406180342.41100.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3cc2EX29X/RgR76S"
Content-Disposition: inline
In-Reply-To: <200406180342.41100.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3cc2EX29X/RgR76S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 03:42:39 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200406180342.41100.dtor_core@ameritech.net>:
> ChangeSet@1.1798, 2004-06-18 02:31:47-05:00, dtor_core@ameritech.net
>   Input: allow users manually rebind serio ports, like this:
>          echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
>          echo -n "atkbd" > /sys/bus/serio/devices/serio1/driver
>          echo -n "none" > /sys/devices/serio1/driver
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

I specifically like this one.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--3cc2EX29X/RgR76S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0rOJHb1edYOZ4bsRAmaFAJ9qo47SAwW+o6GSIkW+hoKYUINGIACfX8oG
v32wLHduOAZyzb99ZVGv6ws=
=HDwI
-----END PGP SIGNATURE-----

--3cc2EX29X/RgR76S--

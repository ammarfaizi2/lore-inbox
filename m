Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUEKM4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUEKM4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEKM4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:56:51 -0400
Received: from legolas.restena.lu ([158.64.1.34]:64974 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264702AbUEKM4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:56:45 -0400
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
From: Craig Bradney <cbradney@zip.com.au>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <40A0B7E4.7060103@keyaccess.nl>
References: <409F4944.4090501@keyaccess.nl>
	 <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl>
	 <200405102352.24091.bzolnier@elka.pw.edu.pl>
	 <40A0B7E4.7060103@keyaccess.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6nEbvgABwut16BHKeW/7"
Message-Id: <1084280198.9420.5.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 14:56:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6nEbvgABwut16BHKeW/7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-11 at 13:24, Rene Herman wrote:
> Bartlomiej Zolnierkiewicz wrote:
>=20
> > Rene, can you send me copies of /proc/ide/hda/identify and
> > /proc/ide/hdc/identify?
>=20
> Sure, attached. Quite sure you wanted hdc though? That's a DVD-ROM.
>=20
> > I still would like to know why these drives don't accept flush cache=20
> > commands (or it is a driver's bug?).
>=20
> No idea I'm afraid. Seems at least new Maxtor drives are affected. Both
> the "120P0" (120G, 8M cache) and "L0" (120G, 2M cache) were reported in
> this thread.

At a guess the 80P0 drives will also be affected (80G, 8mb cache), but
as yet I havent tried 2.6.6 on the boxes with them. Tonight if theres
time.

Craig

--=-6nEbvgABwut16BHKeW/7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAoM2Gi+pIEYrr7mQRAritAKCXxMouIcF1ljgTiiadie7eZKkZlQCeJtjb
ZrwM5R+ZB589+6o59jTTIrU=
=mP8h
-----END PGP SIGNATURE-----

--=-6nEbvgABwut16BHKeW/7--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTHVNvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTHVNvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:51:13 -0400
Received: from D72ae.pppool.de ([80.184.114.174]:31883 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263215AbTHVNvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:51:10 -0400
Subject: Re: How to use an USB<->serial adapter?
From: Daniel Egger <degger@fhm.edu>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F44BEA2.8010108@freemail.hu>
References: <3F44BEA2.8010108@freemail.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zRA4bMmrUbVJlof5mrqv"
Message-Id: <1061507883.8723.45.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Aug 2003 01:18:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zRA4bMmrUbVJlof5mrqv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-08-21 um 14.44 schrieb Boszormenyi Zoltan:

> usb.c: registered new driver serial
> usbserial.c: USB Serial support registered for Generic
> usbserial.c: USB Serial Driver core v1.4
> usbserial.c: USB Serial support registered for PL-2303
> usbserial.c: PL-2303 converter detected
> usbserial.c: PL-2303 converter now attached to ttyUSB0 \
> (or usb/tts/0 for devfs)
> pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9

Works for me, even on PowerPC. I'm typically using minicom and ckermit
but mgetty and others work fine, too.

> setserial produces an error:

What do you need this relic from former times for?

--=20
Servus,
       Daniel

--=-zRA4bMmrUbVJlof5mrqv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/RVMrchlzsq9KoIYRAoloAJ99/NzoHaPewKanhgOZfjVEF/fouACgtFxZ
GYOEQgqLGPEaw8s2onXLlh4=
=W80b
-----END PGP SIGNATURE-----

--=-zRA4bMmrUbVJlof5mrqv--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVB1WmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVB1WmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVB1WmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:42:19 -0500
Received: from smtp.gentoo.org ([134.68.220.30]:6876 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261792AbVB1WmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:42:16 -0500
Subject: Re: [WATCHDOG] correct sysfs name for watchdog devices
From: Henrik Brix Andersen <brix@gentoo.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050227203949.GD6650@infomag.infomag.iguana.be>
References: <20050227203949.GD6650@infomag.infomag.iguana.be>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O8PmjZgkg+ljB9zoDulR"
Organization: Gentoo Linux
Date: Mon, 28 Feb 2005 23:42:10 +0100
Message-Id: <1109630530.20308.6.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O8PmjZgkg+ljB9zoDulR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-02-27 at 21:39 +0100, Wim Van Sebroeck wrote:
>  drivers/char/watchdog/scx200_wdt.c  |    2 +-

This particular change is also included in my scx200 patch:
http://dev.gentoo.org/~brix/files/net4801/linux-2.6.11-rc5-scx200.patch
  =20
>    Signed-off-by: Olaf Hering <olh@suse.de>
>    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

./Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-O8PmjZgkg+ljB9zoDulR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCI55Cv+Q4flTiePgRAkvmAJ40M34BOLjb9bfScLIVMrryhR5raACePpg1
LVfd2WCpiYKNQD+6+rbG5VQ=
=fgyM
-----END PGP SIGNATURE-----

--=-O8PmjZgkg+ljB9zoDulR--


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSE3TeI>; Thu, 30 May 2002 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSE3TeH>; Thu, 30 May 2002 15:34:07 -0400
Received: from ppp-217-133-209-102.dialup.tiscali.it ([217.133.209.102]:39648
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316844AbSE3TeH>; Thu, 30 May 2002 15:34:07 -0400
Subject: Re: [PATCH] [2.4] ATM driver for the Alcatel SpeedTouch USB DSL
	modem
From: Luca Barbieri <ldb@ldb.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020530184817.GB28893@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FaXOys1nCY6WzPKLekrO"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 21:33:58 +0200
Message-Id: <1022787238.1921.185.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FaXOys1nCY6WzPKLekrO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Because of these dependencies (and the fact that the maintainer doesn't
> want it added yet) I will not apply this patch.
That's ok (right now). Application of it should only be considered after
discussion here and after the maintainer responds.

> Sending this to linux-usb-devel might be a better place, instead of
> bothering linux-kernel.
Should I have sent the first two patches to linux-kernel, the ATM SAR to
linux-atm-general and the SpeedTouch driver to linux-usb-devel?
How should I have handled the fact that the SpeedTouch and ATM SAR
patches depend on main kernel patches and the fact that the SpeedTouch
patch includes ATM code (since it is for an ATM device attached to the
USB bus)?


--=-FaXOys1nCY6WzPKLekrO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA89n6mdjkty3ft5+cRAo+bAJ9TtnLyOsJEML8sNMDd3J3JTGxmTwCg1BvF
3v9EAu3C1PaQ9OaXfLTNzJ8=
=Q0x7
-----END PGP SIGNATURE-----

--=-FaXOys1nCY6WzPKLekrO--

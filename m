Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTBKMVx>; Tue, 11 Feb 2003 07:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbTBKMVx>; Tue, 11 Feb 2003 07:21:53 -0500
Received: from host213-121-98-76.in-addr.btopenworld.com ([213.121.98.76]:25005
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267708AbTBKMVx>; Tue, 11 Feb 2003 07:21:53 -0500
Subject: Re: Evil bug in netfilter/kernel 2.4.x?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: jpiszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E482899.9070906@lucidpixels.com>
References: <3E482899.9070906@lucidpixels.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ZUQbNUsiCLUCviN5pTkK"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Feb 2003 12:31:56 +0000
Message-Id: <1044966716.1118.82.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZUQbNUsiCLUCviN5pTkK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-10 at 22:32, jpiszcz wrote:
> However, when I run tcpdump, I can clearly see these are not getting=20
> dropped or logged by the kernel.

Could your problem actually be a testing flaw? tcpdump sees firewalled
packets since it works at packet level, below the IP stack.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-ZUQbNUsiCLUCviN5pTkK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+SO07kbV2aYZGvn0RAtUCAJ9+cArEpYgTq2cv25A56fAvAdT9nACeM+l+
l79PJJBUzX99eytortu8sss=
=9cWT
-----END PGP SIGNATURE-----

--=-ZUQbNUsiCLUCviN5pTkK--


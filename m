Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265793AbSKAWD5>; Fri, 1 Nov 2002 17:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265794AbSKAWD5>; Fri, 1 Nov 2002 17:03:57 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:33322 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265793AbSKAWDz>;
	Fri, 1 Nov 2002 17:03:55 -0500
Date: Fri, 1 Nov 2002 23:10:18 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Bernd Petrovitsch <bernd@gams.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021101231017.A30367@jaquet.dk>
References: <20021101071700.A19847@jaquet.dk> <27827.1036188313@frodo.gams.co.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <27827.1036188313@frodo.gams.co.at>; from bernd@gams.at on Fri, Nov 01, 2002 at 11:05:13PM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Trimmed CC down, this is getting specific).

On Fri, Nov 01, 2002 at 11:05:13PM +0100, Bernd Petrovitsch wrote:
> Just looking at the patch sizes, I thought all are independent=20
> (though "allinone" indicates something different). So I applied all=20
> to one tree (which gave the above mentioned result).
> Now playing around with the patches shows that 2.5.44-allinone
> apparently contains all others _except_ 2.5.44-initstr which is=20
> completely independent.

Yes. Sorry for not stating that more explicitly in my original
mail.=20

> Sorry for the confusion.

On the contrary: I am sorry.

Regards,
  Rasmus

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wvvJlZJASZ6eJs4RAh1XAJ9OhI7RrjXH6na3GeitQFXQSP3jJgCfUW13
G/0M37yoUlPDn6uJZK7oTu0=
=bkKf
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

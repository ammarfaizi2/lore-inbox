Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBDOCv>; Tue, 4 Feb 2003 09:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBDOCv>; Tue, 4 Feb 2003 09:02:51 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:41997 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267268AbTBDOCu>; Tue, 4 Feb 2003 09:02:50 -0500
Date: Tue, 4 Feb 2003 15:12:14 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: John Bradford <john@grabjohn.com>
Cc: Martin Hermanowski <martin@martin.mh57.de>, Valdis.Kletnieks@vt.edu,
       assembly@gofree.indigo.ie, linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030204141214.GB4102@arthur.ubicom.tudelft.nl>
References: <20030203190920.GO1472@martin.mh57.de> <200302031920.h13JKZZd001140@darkstar.example.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <200302031920.h13JKZZd001140@darkstar.example.net>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2003 at 07:20:34PM +0000, John Bradford wrote:
> Does anybody have any data on frequency throttling on non-X86
> architectures?

See http://www.lart.tudelft.nl/projects/scaling/ for papers describing
clock&voltage scaling on StrongARM SA-1100. The same page also has my
OLS 2002 cpufreq overview paper.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
WWW: http://www-ict.its.tudelft.nl/~erik/

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+P8o+/PlVHJtIto0RAmlwAJ9eSz4jix+RyH9ADjCfjkdpwmZnXgCfdGx2
dgQV9Qv0IBnIw/nGuIMyC3A=
=tDE5
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

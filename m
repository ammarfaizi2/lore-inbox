Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271941AbRIILFd>; Sun, 9 Sep 2001 07:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271943AbRIILFO>; Sun, 9 Sep 2001 07:05:14 -0400
Received: from warande3094.warande.uu.nl ([131.211.123.94]:57930 "EHLO
	warande3094.warande.uu.nl") by vger.kernel.org with ESMTP
	id <S271941AbRIILFD>; Sun, 9 Sep 2001 07:05:03 -0400
Date: Sun, 9 Sep 2001 13:05:23 +0200
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD 760 (761?) AGP
Message-ID: <20010909130523.B7635@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B97D334.E27BDA25@pp.htv.fi> <3B998088.6070206@zianet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <3B998088.6070206@zianet.com>
User-Agent: Mutt/1.3.20i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2001 at 08:20:56PM -0600, Steven Spence wrote:

> If you have it as a module try loading it with  agp_try_unsupported=3D1.
> If its not a module try appending it to lilo.  I have that chipset and=20
> everything
> works fine with those options.  I have a GF2U however not a Radeon.  I can
> get 4x working with side band addressing and fast write.

I have an Asus A7M266 with a AMD 761 chipset. I can get agpgart to work with
agp_try_unsupported=3D1, and it works fine, but I only get AGP 1x support.

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7m0zzAxLow12M2nsRAqDpAJ9AC4z03+twK4iI4gkfty/2mkyp6ACfU9JB
udgPM5y9kgx+fYVYLTEBO4s=
=8ZOQ
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

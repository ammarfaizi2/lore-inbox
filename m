Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292373AbSB0NCC>; Wed, 27 Feb 2002 08:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292407AbSB0NBn>; Wed, 27 Feb 2002 08:01:43 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:55823 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S292373AbSB0NBk>;
	Wed, 27 Feb 2002 08:01:40 -0500
Date: Wed, 27 Feb 2002 10:36:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Message-ID: <20020227093643.GA7957@paradigm.rfc822.org>
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org> <3C7BDC57.A835D657@zip.com.au> <20020226191626.GA11283@paradigm.rfc822.org> <OE43IwMw8lODAStRc0J00021292@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <OE43IwMw8lODAStRc0J00021292@hotmail.com>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 10:27:50PM -0500, T. A. wrote:
>     What motherboard are you using?  I recently installed a ICP RAID card
> into a VP6 with dual processors and had similar problems.  I've also had
> problems with the gdth driver under linux in that drives were disappearing
> now and then destroying the integrity of the RAID drive, though in a
> different setup.

Serverworks Chipsset - We dont have any other problems beside the=20
real deadlocks.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fKirUaz2rXW+gJcRAvfjAJ0Y46qkdEhszAA0Tgq9cKqNWXyn2ACgxtAs
VN8AmkSpLD9FtY/mpUwmK7k=
=7Acj
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

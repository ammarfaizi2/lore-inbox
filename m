Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282264AbRKWTTp>; Fri, 23 Nov 2001 14:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282250AbRKWTTg>; Fri, 23 Nov 2001 14:19:36 -0500
Received: from ns.snowman.net ([63.80.4.34]:1542 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S282252AbRKWTTY>;
	Fri, 23 Nov 2001 14:19:24 -0500
Date: Fri, 23 Nov 2001 14:19:16 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Flavio Stanchina <flavio.stanchina@tin.it>,
        linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123141916.Y481@ns>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011123110505.A27707@alcove.wittsend.com> <Pine.LNX.3.96.1011123102729.32257D-100000@mandrakesoft.mandrakesoft.com> <20011123122527.A13163@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DRp5/Sds4nAqvQzf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123122527.A13163@alcove.wittsend.com>; from mhw@wittsend.com on Fri, Nov 23, 2001 at 12:25:27PM -0500
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 2:18pm  up 16 days, 16:40, 14 users,  load average: 1.00, 1.01, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DRp5/Sds4nAqvQzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Michael H. Warfield (mhw@wittsend.com) wrote:
> On Fri, Nov 23, 2001 at 10:27:45AM -0600, Jeff Garzik wrote:
> > On Fri, 23 Nov 2001, Michael H. Warfield wrote:
> > > 	Point is that it BROKE some things....  Like "make install" on
> > > RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turke=
y,
> > > breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> > > like you expected it to be.  Not funny.  Just had three freeswan
> > > kinstall builds blow up because of that.
>=20
	Uh, so don't make assumptions on what the kernel rev. is going
	to be?  It's not that hard to figure it out from the Makefile.

		Stephen

--DRp5/Sds4nAqvQzf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7/qE0rzgMPqB3kigRAucbAKCRY0TQ3aHoZAkZdRQvvCGzF6pUJQCfVOWF
tqDcTl7/BNlxxGSJi54J0yI=
=CSUz
-----END PGP SIGNATURE-----

--DRp5/Sds4nAqvQzf--

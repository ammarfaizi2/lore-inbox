Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKRNKj>; Sun, 18 Nov 2001 08:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279483AbRKRNKa>; Sun, 18 Nov 2001 08:10:30 -0500
Received: from ns.snowman.net ([63.80.4.34]:21512 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S279407AbRKRNKT>;
	Sun, 18 Nov 2001 08:10:19 -0500
Date: Sun, 18 Nov 2001 08:10:13 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: /sbin/mount and /proc/mounts difference
Message-ID: <20011118081013.Q481@ns>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20011118135007.A787@Zenith.starcenter>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sL7C0a98p/u5aVah"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011118135007.A787@Zenith.starcenter>; from sven.vermeulen@rug.ac.be on Sun, Nov 18, 2001 at 01:50:07PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:09am  up 11 days, 10:32, 12 users,  load average: 1.00, 1.00, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sL7C0a98p/u5aVah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Sven Vermeulen (sven.vermeulen@rug.ac.be) wrote:
>=20
> As you can see the notail-option of reiserfs isn't listed on /proc/mounts,
> but it is on "mount".
>=20
> Does this have any particular reason?

	Sure, mount reads /etc/mtab.

		Stephen

--sL7C0a98p/u5aVah
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE797M1rzgMPqB3kigRAu/JAJ9cGQpXL6hYT8rIscPZpMnERwp7hQCeMDiH
pyw2wmk/ub+NeoBqNPXOVOI=
=SWDq
-----END PGP SIGNATURE-----

--sL7C0a98p/u5aVah--

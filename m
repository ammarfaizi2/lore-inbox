Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286189AbRLJIMG>; Mon, 10 Dec 2001 03:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286190AbRLJILz>; Mon, 10 Dec 2001 03:11:55 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:35296 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S286189AbRLJILw>;
	Mon, 10 Dec 2001 03:11:52 -0500
Date: Mon, 10 Dec 2001 10:14:52 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.16 & OOM killer screw up
Message-ID: <20011210101452.F1502@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:38am  up 19 min,  2 users,  load average: 0.09, 0.04, 0.04
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

If I leave my machine on for a day or two without doing anything on it (e.g.
my machine at work over a weekend) and I come back then 1) all my memory is
used for buffers/caches and when I try running application, the OOM killer
kicks in, tries to allocate swap space (which I don't have) and kills
whatever I try start (that's with 300M+ memory in buffers/caches).

--=20

Regards
 Abraham

Man must shape his tools lest they shape him.
		-- Arthur R. Miller

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FG78zNXhP0RCUqMRAkWRAJ43AZ2W12WqbUchwKZy2AA9JruepQCeMYmJ
Zt7bAn209o9EwZfXBNxwdN8=
=V4Eo
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--

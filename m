Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263004AbSJGMUU>; Mon, 7 Oct 2002 08:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263006AbSJGMUU>; Mon, 7 Oct 2002 08:20:20 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:7628 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S263004AbSJGMUT>;
	Mon, 7 Oct 2002 08:20:19 -0400
Date: Mon, 7 Oct 2002 14:10:53 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, simon@baydel.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007141053.B14444@crystal.2d3d.co.za>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>, simon@baydel.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20021005.212832.102579077.davem@redhat.com> <1033923206.21282.28.camel@irongate.swansea.linux.org.uk> <3DA16A9B.7624.4B0397@localhost> <20021007.033644.85392050.davem@redhat.com> <20021007125755.A5381@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021007125755.A5381@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Oct 07, 2002 at 12:57:55 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 2:03pm  up 5 days, 22:58,  6 users,  load average: 0.00, 0.05, 0.12
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell!

> And as final proof, the solution taken by two embedded companies is
> to develop two completely separate cs89x0 driver from the existing one
> (and then pick one/merge them) rather than fixing stuff in the way
> suggested by Alan.

Hey, the original cs89x0 driver were just too ugly to actually work on -
It was much more productive to just start from scratch (;

--=20

Regards
 Abraham

To kick or not to kick...
	-- Somewhere on IRC, inspired by Shakespeare

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9oXnNzNXhP0RCUqMRAsPNAJ9lDZ2/dEtQRpA2Aauid0R9eU4/YgCgj6PM
c2OpB1Ke/fSsw4YfwWKtM1A=
=YSNv
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

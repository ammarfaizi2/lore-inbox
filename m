Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263564AbUEHQ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUEHQ7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUEHQ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 12:59:08 -0400
Received: from zak.futurequest.net ([69.5.6.152]:19928 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S263584AbUEHQ7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 12:59:04 -0400
Date: Sat, 8 May 2004 10:59:02 -0600
From: Bruce Guenter <bruceg@em.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040508165902.GF25615@em.ca>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org> <20040506195223.017cd7f6.akpm@osdl.org> <1083903398.7481.43.camel@bach> <200405072213.23167.rjwysocki@sisk.pl> <20040507230915.447a92fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20040507230915.447a92fa.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2004 at 11:09:15PM -0700, Andrew Morton wrote:
> Works for me too.  Can you share your kernel boot commandline with us?

Sure.  I use (in grub):
	kernel /vmlinuz-2.6.6-rc2-mm2 vga=3D1 ro root=3D/dev/md15 elevator=3Ddeadl=
ine console=3DttyS0,115200n8
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAnRHW6W+y3GmZgOgRAjYOAJ0SGqYs9ZlT9445ou5AuvcJ+bUMWACgp6Ni
qWfGMioW7nFqze4LDwr8k9o=
=jUhx
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

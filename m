Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312894AbSDYDmk>; Wed, 24 Apr 2002 23:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312895AbSDYDmj>; Wed, 24 Apr 2002 23:42:39 -0400
Received: from dhcp065-025-113-164.neo.rr.com ([65.25.113.164]:13052 "EHLO
	zahra") by vger.kernel.org with ESMTP id <S312894AbSDYDmj>;
	Wed, 24 Apr 2002 23:42:39 -0400
Date: Wed, 24 Apr 2002 23:42:28 -0400
From: James Cassidy <jcassidy@cs.kent.edu>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
Message-ID: <20020425034227.GA445@qfire.net>
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


    You could always copy the process to a RAM filesystem like tmpfs
or a ramdisk.=20

On Wed, Apr 24, 2002 at 10:47:14PM -0400, Eric Buddington wrote:
> Is there any way to dissociate a process from its on-disk binary?  In
> other words, I want to start 'foo_daemon', then unmount the filesystem
> it started from. It seems to me this would be reasonably accomplished
> by loading the binary completely into memory first ro eliminate the
> dependence.
>=20
> Is this possible, or planned? Are there intractable problems with it
> that I don't see?
>=20
> Eric Buddington
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
						-- James Cassidy (QFire)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8x3sjJanLLdMos+kRAuZBAKDAkWsc59VW+CG/lYv4axpstr8fCACfSCYN
26OTQEpk/LJK8rTLkULA3sA=
=+SGq
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

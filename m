Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbSJBWXV>; Wed, 2 Oct 2002 18:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbSJBWXU>; Wed, 2 Oct 2002 18:23:20 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:9137 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262657AbSJBWXQ>; Wed, 2 Oct 2002 18:23:16 -0400
Date: Wed, 2 Oct 2002 17:27:47 -0500
From: Shawn <core@enodev.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021002172747.A4931@q.mn.rr.com>
References: <02100216332002.18102@boiler> <Pine.GSO.4.21.0210021812590.9782-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0210021812590.9782-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Oct 02, 2002 at 06:14:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since I am personally hoping for EVMSs inclusion, I just wanted to thank
you for being constructive in pointing out specific issues so that they
can be addressed.

Hopefully, folks can keep from starting a religious war. This /is/
fertile ground for one, too... Heavyweights have weighed in on all sides
of this fence, making (md|.*Volume Manage\S+) a very contentious topic...

On 10/02, Alexander Viro said something like:
> On Wed, 2 Oct 2002, Kevin Corry wrote:
> > On behalf of the EVMS team, I'd like to submit the Enterprise Volume
> > Management System for inclusion in the 2.5 Linux kernel tree.
> >=20
> > To make this as simple as possible for you, there is a Bitkeeper
> > tree available with the latest EVMS source code, located at:
> > http://evms.bkbits.net/linux-2.5
> > This tree is sync'd with the linux-2.5 tree on linux.bkbits.net
> > as of about noon today (Oct 2).
> =20
> > - Add a function, walk_gendisk(), to drivers/block/genhd.c to allow
> >   EVMS to get information about the disks on the system from the
> >   gendisk list in a safe manner.
>=20
> Consider that one vetoed.  Linus, please do _not_ apply until that
> stuff is resolved - it conflicts with a bunch of cleanups we'll
> need.

--
Shawn Leas
core@enodev.com

I got a new shadow. I had to get rid of the other one
						--  it wasn't doing
what I was doing.
						-- Stephen Wright

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9m3LjubgCGkrWpN4RAttFAJ93Kkys9UcF78x0gk5ZJGOggDmOoACguqTI
PJPR2ur+3k+6NrhqEdLVstQ=
=eTGS
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

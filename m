Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285067AbRLRUbx>; Tue, 18 Dec 2001 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbRLRUbj>; Tue, 18 Dec 2001 15:31:39 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:9721
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S285067AbRLRUaV>; Tue, 18 Dec 2001 15:30:21 -0500
Date: Tue, 18 Dec 2001 14:30:19 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Alexander Viro'" <viro@math.psu.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011218203019.GC9314@0xd6.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grover, Andrew <andrew.grover@intel.com> on Tue, Dec 18, 2001:

> > From: Alexander Viro [mailto:viro@math.psu.edu]
> > On Tue, 18 Dec 2001, Grover, Andrew wrote:
> > > GRUB 0.90 does this today.
> > ... and I'm quite sure that EMACS could do it easily.  Let's not talk
> > about GNU bloatware, OK?
>=20
> I don't think this is bloatware, especially considering there really isn't
> any cost for having a full-featured bootloader - all its footprint gets
> reclaimed, after all. I respect lilo and its cousins, but they make things
> harder than they have to be. Why maintain a reduced level of functionality
> (software emaciation?) when better alternatives are available?
>=20

Available for what?  SuperH?  MIPS?  IA-64?  Your precious GRUB and
Multiboot "standard" are only ever useful on the x86 architecture, so you
would propose a x86-specific global change that doesn't benefit the rest of
the other kernel archs?  Bloat for the sake of?

>=20
> > IOW, we are backwards compatible with old
> > loaders.
>=20
> No progress will ever be made if we cater to the lowest common denominato=
r.
>=20

The i386.

M. R.

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8H6dbaK6pP/GNw0URAoUDAJ0d2FacdHI23VQbs/EPUk4rqrpGWwCfeC21
UCqbewW8pbD68t2nji6Khd4=
=pA/8
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWAKDqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWAKDqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWAKDqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:46:23 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:5337 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932789AbWAKDqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:46:22 -0500
Date: Wed, 11 Jan 2006 14:46:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <matthew@wil.cx>
Cc: hch@lst.de, kyle@parisc-linux.org, akpm@osdl.org, carlos@parisc-linux.org,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-Id: <20060111144600.6e75fad4.sfr@canb.auug.org.au>
In-Reply-To: <20060110163943.GY19769@parisc-linux.org>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca>
	<20060109141355.GA22296@lst.de>
	<20060110150141.GE28306@quicksilver.road.mcmartin.ca>
	<20060110151547.GB17621@lst.de>
	<20060110163943.GY19769@parisc-linux.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__11_Jan_2006_14_46_00_+1100_qeTvPHWLvm=X_lGb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__11_Jan_2006_14_46_00_+1100_qeTvPHWLvm=X_lGb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jan 2006 09:39:43 -0700 Matthew Wilcox <matthew@wil.cx> wrote:
>
> On Tue, Jan 10, 2006 at 04:15:47PM +0100, Christoph Hellwig wrote:
> > Yes, the is_compat_task helper is a nice thing to have.  I haven't
> > needed it for the signal bits I've done yet, but it's also useful
> > elsewhere.  But IIRC someone vehemently opposed it in the last round
> > of discussion.
>=20
> Andi's now dropped his opposition, so I think we're fine.

And I think DaveM got tired :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__11_Jan_2006_14_46_00_+1100_qeTvPHWLvm=X_lGb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDxH94FdBgD/zoJvwRApEsAJ9G9jJ+dKmS3IRLBBHcjq+83RbTIACeOvOH
np++elF9NJ8chDu9fUYaeP4=
=0QMe
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Jan_2006_14_46_00_+1100_qeTvPHWLvm=X_lGb--

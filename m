Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWCWGru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWCWGru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWCWGru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:47:50 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:21425 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932368AbWCWGrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:47:47 -0500
Date: Thu, 23 Mar 2006 17:47:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miles Bader <miles@gnu.org>
Cc: miles.bader@necel.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-Id: <20060323174719.6d4387ff.sfr@canb.auug.org.au>
In-Reply-To: <buofyl9llau.fsf@dhapc248.dev.necel.com>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
	<buofyl9llau.fsf@dhapc248.dev.necel.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__23_Mar_2006_17_47_19_+1100_B19FhjzL4/7qH+P+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__23_Mar_2006_17_47_19_+1100_B19FhjzL4/7qH+P+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 15:36:25 +0900 Miles Bader <miles.bader@necel.com> wrot=
e:
>
> BTW, why not keep use the parisc version of the structure for the common
> version, as it has comments for each field (not world breaking, but a
> nice little thing)?

I figured if you wanted to understand the structure, you could look at the
real struct timex.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Mar_2006_17_47_19_+1100_B19FhjzL4/7qH+P+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIkR8FdBgD/zoJvwRAhTVAJ9GUbyaG41Q2R9hd1s4+VOv/GmS8gCfffcx
NTZewrVybgslsynMYYKZ3nw=
=IdTO
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Mar_2006_17_47_19_+1100_B19FhjzL4/7qH+P+--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDOQdI (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTDOQdI 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:33:08 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:13837 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261783AbTDOQdF (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:33:05 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Tue, 15 Apr 2003 12:44:40 -0400
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030415164435.GA6389@rivenstone.net>
Mail-Followup-To: Alessandro Suardi <alessandro.suardi@oracle.com>,
	linux-kernel@vger.kernel.org
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <3E9C03DD.3040200@oracle.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 03:06:37PM +0200, Alessandro Suardi wrote:
<snip>
> I surely hit bug 543 in 2.5.65 IIRC, and guess what...
>  ATI Radeon 7500 Mobile - XFree 4.2.1
>=20
> According to other emails on lkml, it appears that DRM and/or AGP
>  new kernel code might be at fault. I don't actually remember
>  seeing non-Radeon cards being hit by such problems though...
>=20
> When the ex-PC from my brother is supplied a new USB keyboard and
>  a hard disk I'll try reproducing on its Voodoo5 :)

    I've seen this problem too many times, but haven't tried to track
it down.  The video is ATI Rage 128 Pro.

    A common bit seems to be ATI cards, judging from this thread.  I'm
also using the aty128fb framebuffer driver.  My motherboard is Aladdin V
based and so uses the ali-agp module.

    I wonder if all of us who are seeing this problem have any of
these other things in common? =20

--=20
Joseph Fannin
jhf@rivenstone.net

"I think I said something eloquent, like 'Fuck.'" -- Rusty Russell.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nDbzWv4KsgKfSVgRAgNTAKCPksghOKLUDJ6tINcO2MczsvrqcgCdFaU6
f1hs74YGFEUGgZ9Pnakcpj0=
=2ZzX
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

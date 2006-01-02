Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWABNDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWABNDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWABNDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:03:16 -0500
Received: from mail.gmx.net ([213.165.64.21]:50613 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750713AbWABNDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:03:15 -0500
X-Authenticated: #5339386
Date: Mon, 2 Jan 2006 14:00:45 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc7
Message-ID: <20060102130042.GC21933@sidney>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051230194435.GA7088@sidney> <43B5E191.3030705@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <43B5E191.3030705@gmail.com>
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 31, 2005 at 02:40:33AM +0100, Jiri Slaby wrote:
> Mathias Klein napsal(a):
> > Hello,
> >=20
> > i recently got another oops. As suggested by Pekka Enberg I've enabled
> > CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.
> [snip]
> > Dec 30 20:12:11 sidney kernel: [31895.553014] Oops: 0000 [#1]
> > Dec 30 20:12:11 sidney kernel: [31895.553065] PREEMPT=20
> btw. this is not kernel with CONFIG_DEBUG_PAGEALLOC.

Ehmm. Yes, Sorry. Will be included in my next build.
Thank you for notify.

> regards,
> --=20
> Jiri Slaby         www.fi.muni.cz/~xslaby
> \_.-^-._   jirislaby@gmail.com   _.-^-._/
> B67499670407CE62ACC8 22A032CC55C339D47A7E

Mathias
=20

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuSP6PtJqRGqEpd8RAumzAJ9EIqsu8iSkxwE92NA3bGoCuFA72wCfVwX2
7xQhr4V/wtkDRiChlD9mW2U=
=bAnS
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--

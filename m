Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUFGMfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUFGMfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUFGMfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:35:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264649AbUFGMNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 08:13:12 -0400
Date: Mon, 7 Jun 2004 14:13:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Russell Leighton <russ@elegant-software.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->	getpid() bug in 2.6?]
Message-ID: <20040607121300.GB9835@devserv.devel.redhat.com>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com> <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com> <40C3AD9E.9070909@elegant-software.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <40C3AD9E.9070909@elegant-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Sun, Jun 06, 2004 at 07:49:50PM -0400, Russell Leighton wrote:
> Arjan van de Ven wrote:
> 
> >Note also that
> >
> >clone() is not a portable interface even within linux architectures.
> >
> > 
> >
> Really???!!! How so?

for example ia64 doesn't have it.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxFvLxULwo51rQBIRAmg4AJ90C1HN+u+zP0akipslIBMsQ/ytdACgnCdc
S27hkx/UY3APCIU4r6tyeA4=
=pCbd
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

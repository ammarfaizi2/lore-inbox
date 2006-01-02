Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWABQwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWABQwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWABQwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:52:25 -0500
Received: from mail.gmx.net ([213.165.64.21]:35996 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750869AbWABQwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:52:24 -0500
X-Authenticated: #5082238
Date: Mon, 2 Jan 2006 17:52:31 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
Message-ID: <20060102165231.GA23834@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <p73k6difvm3.fsf@verdi.suse.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2006 at 05:22:12PM +0100, Andi Kleen wrote:
> When you not compile in the SKGE network driver does everything else work?
> skge supports 64bit DMA, so it shouldn't use any IOMMU.  But I'm somewhat
> suspicious of the >4GB support in the VIA chipset. We had problems with
> that before. It's possible that it's just not supported in the hardware
> or that the BIOS sets up the MTRRs wrong.

How can I find that out? Can I provide any useful material? VIA KT800Pro
and 4GB RAM here..

PS: I am not the original poster, but have a similar problem.

Thanks,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuVpPjUF4jpCSQBQRAtSYAKCe4Xg0yUeb4OQSRNI4UHFCfactfgCfWKcH
MF3MzQQSswwlSR7YDnFahHg=
=P843
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

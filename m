Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWACVyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWACVyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWACVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:54:05 -0500
Received: from mail.gmx.net ([213.165.64.21]:44988 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964967AbWACVyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:54:01 -0500
X-Authenticated: #5082238
Date: Tue, 3 Jan 2006 23:54:01 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
Message-ID: <20060103225401.GA10569@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de> <20060102165231.GA23834@carsten-otto.halifax.rwth-aachen.de> <p73bqyufo97.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <p73bqyufo97.fsf@verdi.suse.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2006 at 08:01:08PM +0100, Andi Kleen wrote:
> Alternatively you can try with the appended patch. If that helps
> then the chipset or the BIOS likely has some fundamental issue with >4GB.

Based on the first few minutes of testing this works perfectly! Thanks a
lot!

PS: Does it make sense to contact my shop and/or Abit and/or VIA
regarding this problem? I don't want to pay money for broken hardware.
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuwCJjUF4jpCSQBQRAh78AKC+rj7Jrxx3K1sOz3/eM3M5Pb/WTQCeKeW3
geH5DVQDhGqI9rtRN+BBdTw=
=4KOp
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

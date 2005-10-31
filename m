Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVJaTHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVJaTHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJaTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:07:10 -0500
Received: from mail.satronet.sk ([217.144.16.198]:40357 "EHLO mail.satronet.sk")
	by vger.kernel.org with ESMTP id S964792AbVJaTHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:07:09 -0500
From: Michal Vanco <michal.vanco@satro.sk>
Organization: Satro, s.r.o.
To: Jens Axboe <axboe@suse.de>
Subject: Re: HDD LED on 82801FBM
Date: Mon, 31 Oct 2005 20:06:35 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510311944.45295.michal.vanco@satro.sk> <20051031190537.GB19267@suse.de>
In-Reply-To: <20051031190537.GB19267@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1733358.hTzUEfVNCR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510312006.37425.michal.vanco@satro.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1733358.hTzUEfVNCR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

D=C5=88a Monday 31 October 2005 20:05 Jens Axboe nap=C3=ADsal:
> On Mon, Oct 31 2005, Michal Vanco wrote:
> > Hi all,
> >
> > HDD LED on my Laptop (Fujitsu-Siemens LB E8020) never goes off when
> > 2.6 kernel is running (tested with 2.6.10-2.6.13.4).
>
> It's a bug in the ahci driver, which coincidentally is fixed with
> 2.6.14. So you should upgrade :)

:) thanks ... i should read changelogs :)

=2Dm

--nextPart1733358.hTzUEfVNCR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZms9cNQdtX6Dm/0RAuiBAJ0eKZJGmTYKs7yKIMeuw7P998pGfgCgmR2X
H0CDbAr3Hupzev7XC1S3tqo=
=q16r
-----END PGP SIGNATURE-----

--nextPart1733358.hTzUEfVNCR--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265639AbSJXUew>; Thu, 24 Oct 2002 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbSJXUew>; Thu, 24 Oct 2002 16:34:52 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:52024 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265639AbSJXUev>;
	Thu, 24 Oct 2002 16:34:51 -0400
Date: Thu, 24 Oct 2002 22:40:59 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Message-ID: <20021024224059.A18265@jaquet.dk>
References: <20021023215117.A29134@jaquet.dk> <1035393119.10067.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035393119.10067.13.camel@localhost.localdomain>; from joe@perches.com on Wed, Oct 23, 2002 at 01:11:58PM -0400
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2002 at 01:11:58PM -0400, Joe Perches wrote:
> kernel.h already has #defines for pr_debug and pr_info.
> perhaps all 8 current KERN_xxx's could be pr_#define'd
> and the printks converted during 2.7+

Possibly. Certainly fine by me.

> I think this should be done together with Larry Kessler's
> kernel logging proposal.

I only followed this discussion superficially. Would you mind
providing a link for the thread or giving me a short roundup
of the conclusion on that?

Thanks,
  Rasmus

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uFralZJASZ6eJs4RApABAKCHLodcMzD2zIAs5+KN1hq3bZyDYgCeILAn
hhkgvbXYd3vEdlHQypvwbE0=
=JQqg
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbULFJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbULFJnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbULFJnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:43:19 -0500
Received: from 151.adsl.as8758.net ([212.25.16.151]:58887 "EHLO
	johnny.adanco.com") by vger.kernel.org with ESMTP id S261475AbULFJnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:43:02 -0500
From: "Adrian 'Dagurashibanipal' von Bidder" <avbidder@fortytwo.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Proposal for a userspace "architecture portability" library
Date: Mon, 6 Dec 2004 10:42:54 +0100
User-Agent: KMail/1.7.1
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
In-Reply-To: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1584492.i64buGQfbE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412061042.59549@fortytwo.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1584492.i64buGQfbE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 05 December 2004 01.53, Paul Mackerras wrote:
> Some of our kernel headers implement generally useful abstractions
> across all of the architectures we support.  I would like to make an
> "architecture portability" library, based on the kernel headers but as
> a separate project from the kernel, and intended for use in userspace.

Doesn't apr cover some of this already? Should such an effort be merged int=
o=20
apr?

Just a thought.
=2D- vbi

=2D-=20
Beware of the FUD - know your enemies. This week
    * The Alexis de Toqueville Institue *
http://fortytwo.ch/opinion/adti

--nextPart1584492.i64buGQfbE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: get my key from http://fortytwo.ch/gpg/92082481

iKcEABECAGcFAkG0KaNgGmh0dHA6Ly9mb3J0eXR3by5jaC9sZWdhbC9ncGcvZW1h
aWwuMjAwMjA4MjI/dmVyc2lvbj0xLjUmbWQ1c3VtPTVkZmY4NjhkMTE4NDMyNzYw
NzFiMjVlYjcwMDZkYTNlAAoJECqqZti935l6XzQAn0MtuAW4+UmE2FDFgU2MHpY8
dBF8AKCwfSR+hfh7oLXGlkX174NVeYO2VQ==
=7Fcy
-----END PGP SIGNATURE-----

--nextPart1584492.i64buGQfbE--

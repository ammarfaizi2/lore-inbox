Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVAEPdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVAEPdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVAEPdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:33:10 -0500
Received: from gate.adanco.com ([212.25.16.151]:18447 "EHLO johnny.adanco.com")
	by vger.kernel.org with ESMTP id S262469AbVAEPR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:17:59 -0500
From: Adrian von Bidder <avbidder@fortytwo.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: How to write elegant C coding (certainly OT)
Date: Wed, 5 Jan 2005 16:17:52 +0100
User-Agent: KMail/1.7.1
References: <41DB8CC3.3040305@globaledgesoft.com> <2cd57c90050104234934ab6201@mail.gmail.com> <20050105081415.GH26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050105081415.GH26051@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1715394.9bsPIlhuYS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501051617.58150@fortytwo.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1715394.9bsPIlhuYS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 January 2005 09.14, Al Viro wrote:
> On Wed, Jan 05, 2005 at 03:49:07PM +0800, Coywolf Qi Hunt wrote:
> > I'd say better to study compile theory and a kind of compiler source
> > code.
>
> Yes, gcc source definitely makes a great cautionary tale about the need
> of writing elegant code and dreadful results of not doing so.


LOL

I specifically recommend the ARM backend.  It was copied from some other=20
RISC target, then a ARM thumb (16bit instruction width) backend was split=20
from that, and finally the thumb and 32bit backends were merged again,=20
apparently without removing much of the duplicated code.

=46un.

=2D- vbi

=2D-=20
featured link: http://fortytwo.ch/gpg/subkeys

--nextPart1715394.9bsPIlhuYS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: get my key from http://fortytwo.ch/gpg/92082481

iKcEABECAGcFAkHcBSZgGmh0dHA6Ly9mb3J0eXR3by5jaC9sZWdhbC9ncGcvZW1h
aWwuMjAwMjA4MjI/dmVyc2lvbj0xLjUmbWQ1c3VtPTVkZmY4NjhkMTE4NDMyNzYw
NzFiMjVlYjcwMDZkYTNlAAoJECqqZti935l6EDMAoL3h+/JtFYQBS5qMFQdzy27t
yrIaAJ0SlPpbq/usFC1G4PFS4sedKsNazA==
=aa9N
-----END PGP SIGNATURE-----

--nextPart1715394.9bsPIlhuYS--

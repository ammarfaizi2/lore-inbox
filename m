Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTFRMWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbTFRMWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:22:51 -0400
Received: from host81-134-138-64.in-addr.btopenworld.com ([81.134.138.64]:32905
	"HELO factotum.office.bytemark.co.uk") by vger.kernel.org with SMTP
	id S265181AbTFRMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:22:50 -0400
From: Pete Taphouse <pete@bytemark.co.uk>
Organization: Bytemark Computer Consulting Ltd
To: Andre Tomt <andre@tomt.net>
Subject: Re: ptrace/kmod exploit still works in 2.4.21?
Date: Wed, 18 Jun 2003 13:36:07 +0100
User-Agent: KMail/1.5.2
References: <200306181222.11691.pete@bytemark.co.uk> <1055936287.7480.136.camel@slurv.ws.pasop.tomt.net>
In-Reply-To: <1055936287.7480.136.camel@slurv.ws.pasop.tomt.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_6yF8+4DA2su/0LT";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306181336.10601.pete@bytemark.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_6yF8+4DA2su/0LT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Wednesday 18 June 2003 12:38, you wrote:
> On ons, 2003-06-18 at 13:22, Pete Taphouse wrote:
> <snip FAQ>
>
> Check your exploit binary for the suid flag. If run successfully once on
> a older kernel, it cheats by setting suid root.
Doh!  Apologies for time/space wastage.

Cheers,
=2D-=20
Peter Taphouse

Bytemark Hosting
http://www.bytemark-hosting.co.uk
tel. +44 (0) 8707 455 026

--Boundary-02=_6yF8+4DA2su/0LT
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8Fy6IAZ7OKeBB58RApCwAJ99dd4ZNTXqqADQqydiM73ZzAiQLQCeKjeW
4/7KK+GAf3TjLYHrjQ7Gs5Q=
=e87H
-----END PGP SIGNATURE-----

--Boundary-02=_6yF8+4DA2su/0LT--


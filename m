Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVLGMec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVLGMec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVLGMec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:34:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:61141 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750946AbVLGMeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:34:31 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Date: Wed, 7 Dec 2005 13:35:41 +0100
User-Agent: KMail/1.9
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051204011953.GA16381@havoc.gtf.org>
In-Reply-To: <20051204011953.GA16381@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3100709.MfkPN4uTuv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512071335.42016.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3100709.MfkPN4uTuv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag Dezember 4 2005 02:19 schrieb Jeff Garzik:
> To make it easy for others to test, since there are merge conflicts,
> I've combined the two previous sata_sil patches into a single patch.
>
> Verified here on my 3112 (Adaptec 1210SA).

Seems to work fine here with my 3112 on nforce2 board, as well.

Cheers,

Prakash

--nextPart3100709.MfkPN4uTuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDltcdxU2n/+9+t5gRAlTUAKDwDFYH8nhJvmZrWV8jPv8slqdApACgqBcx
z58V7KweYA1FCHlO1zWZUBo=
=ogX/
-----END PGP SIGNATURE-----

--nextPart3100709.MfkPN4uTuv--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVERKdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVERKdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVERKcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:32:48 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:17100 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262156AbVERKcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:32:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "linux" <kernel@wired-net.gr>
Subject: Re: 2.6 jiffies
Date: Wed, 18 May 2005 20:32:54 +1000
User-Agent: KMail/1.8
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <1116005355.6248.372.camel@localhost> <1116256279 <001b01c55b92$1d09c6e0$0101010a@dioxide>
In-Reply-To: <001b01c55b92$1d09c6e0$0101010a@dioxide>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2639729.PceE539ysu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505182032.57234.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2639729.PceE539ysu
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 18 May 2005 20:12, linux wrote:
> Why jiffies start counting from a negative number and after 5minutes the
> counter gets positive????

It's an excellent way to test if jiffy wrap is handled well since it will=20
happen in 5 minutes instead of 50 days.

Cheers,
Con

--nextPart2639729.PceE539ysu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCixnZZUg7+tp6mRURAhJGAJ0St/an3zMZCW21B+r6HxEVfVyjaQCfZz5C
QKQE2aHmozLLAvQ3AElsFjk=
=EdSk
-----END PGP SIGNATURE-----

--nextPart2639729.PceE539ysu--

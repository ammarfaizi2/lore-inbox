Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVGLVeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVGLVeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVGLVdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:33:54 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:42899 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262491AbVGLVc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:32:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Wed, 13 Jul 2005 07:32:27 +1000
User-Agent: KMail/1.8.1
Cc: "'David Lang'" <david.lang@digitalinsight.com>,
       "'linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
       "'ck list'" <ck@vds.kolivas.org>
References: <200507122055.XAA10661@raad.intranet>
In-Reply-To: <200507122055.XAA10661@raad.intranet>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1456319.MucuXinFdt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507130732.30535.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1456319.MucuXinFdt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 13 Jul 2005 06:55, Al Boldi wrote:
> On Tue, 12 Jul 2005, Con Kolivas wrote:
> > It runs a real time high priority timing thread that wakes up the thread
>
> Nice, but why is it threaded?

Because I'm an amateur, and I had to start somewhere.

> Forking would be more realistic!

Something for the future would be to fork the background workload separatel=
y=20
from the benchmarked workload. Having them all in the same mm does appear t=
o=20
cause other interactions which pollute the real time data as Ingo has point=
ed=20
out to me privately.

I'm a little burnt out from the effort so far so it can wait.

Thanks for feedback.

Cheers,
Con

--nextPart1456319.MucuXinFdt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1DbuZUg7+tp6mRURAn60AJwP8FRnxiwiPMQP/wt4upgzDD31xQCfW9sU
XzkZ61gYhDLU8ftmZMesbuo=
=iuXm
-----END PGP SIGNATURE-----

--nextPart1456319.MucuXinFdt--

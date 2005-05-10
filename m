Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVEJNQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVEJNQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVEJNQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:16:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:51627 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261636AbVEJNQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:16:15 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Tue, 10 May 2005 15:15:44 +0200
User-Agent: KMail/1.8
Cc: suse-amd64@suse.com, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <200505101355.00341.bernd.paysan@gmx.de> <20050510130709.GI25612@wotan.suse.de>
In-Reply-To: <20050510130709.GI25612@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1456836.KRUGKBVvWJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505101515.56177.bernd.paysan@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1456836.KRUGKBVvWJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 10 May 2005 15:07, Andi Kleen wrote:
> That could be irqbalance doing its thing. Does it go away when
> you stop it?

Yes, it seems to go away.

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--nextPart1456836.KRUGKBVvWJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCgLQMi4ILt2cAfDARAoeGAJ0dNHsTg4Kqy0yDg3vML3zPkAEPbQCeN/Ig
Tf/oI5UZdy8UESbAVH8esIo=
=wzQx
-----END PGP SIGNATURE-----

--nextPart1456836.KRUGKBVvWJ--

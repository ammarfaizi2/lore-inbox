Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDOBlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDOBlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDOBlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:41:51 -0400
Received: from downeast.net ([204.176.212.2]:11769 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261714AbVDOBl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:41:26 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Thu, 14 Apr 2005 21:41:08 -0400
User-Agent: KMail/1.8
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200504142119.04527.pmcfarland@downeast.net> <1113528416.19830.72.camel@mindpipe>
In-Reply-To: <1113528416.19830.72.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1339505.lbDiPv9YzK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504142141.13766.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1339505.lbDiPv9YzK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 14 April 2005 09:26 pm, Lee Revell wrote:
> On Thu, 2005-04-14 at 21:18 -0400, Patrick McFarland wrote:
> > On Thursday 07 April 2005 07:17 am, Patrick McFarland wrote:
> > > Nope, 2.6.7 is also fubar. Now to 2.6.6.
> >
> > I haven't tested 2.6.6 yet, but 2.6.12-rc2-mm3 is broken too.
>
> There's no point in testing newer kernels if you have yet to find an old
> 2.6 kernel where it works.

I didn't explicitly test it. I just updated my usual running kernel, and it=
=20
just happens that it didn't magically start working again.

> Do you have any evidence that it ever worked with ALSA?  I suspect it's
> always been broken, and that 2.6.8 or 2.6.9 system you referred to was
> using the OSS driver.

Nope, I haven't used OSS in a very very very very long time. Back when I us=
ed=20
2.4 (which ended when 2.6.1 was released) I used ALSA.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1339505.lbDiPv9YzK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCXxu58Gvouk7G1cURAm2IAKCJQKhexHtiuHqUFrv7vbXWWgVFTACffnDw
ZtdEGTfDdTag3KoAJ8sW7WU=
=imJ6
-----END PGP SIGNATURE-----

--nextPart1339505.lbDiPv9YzK--

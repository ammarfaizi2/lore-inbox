Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVEVEwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVEVEwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 00:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEVEwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 00:52:40 -0400
Received: from downeast.net ([12.149.251.230]:6619 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261692AbVEVEwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 00:52:37 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Andrew Haninger <ahaning@gmail.com>
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Sun, 22 May 2005 00:50:56 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200505201345.15584.pmcfarland@downeast.net> <105c793f050521182269294d64@mail.gmail.com>
In-Reply-To: <105c793f050521182269294d64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8168467.eIPcGkjeIx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505220051.23222.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8168467.eIPcGkjeIx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 May 2005 09:22 pm, Andrew Haninger wrote:
> > ... flames the LKML about how Linux breaks cdrecord
> > (instead of just admitting cdrecord is broken)
>
> I've always used cdr-tools on Linux and Windows since it is the
> only/best tool for mastering CDs. It takes the installation of Joerg's
> library, but after that, it's worked wonderfully. This is even the
> tool that is suggested by the HOWTOs that newbies are told to read. It
> has always appeared to me that it was the only/best tool.

I was refering to the 2.6 permissions bug in cdrecord. It wouldn't work usi=
ng=20
a non-root user, even if they had the correct permissions. 2.6 changed (for=
=20
the better, mind you), and Joerg refused to fix cdrecord. (I don't know if=
=20
its even fixed now). Theres been other cases of cdrecord breaking on Linux=
=20
only, but I can't think of them atm.

> If it's broken, then surely there's an unbroken drop-in replacement
> program that should be used. And surely it works much better than
> cdr-tools and is easier to use. However, after a few seconds of Google
> searches, I was unable to find it.

I really wish someone would build a replacement for cdrecord, but Joerg jus=
t=20
hasn't pissed off that potential author enough.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart8168467.eIPcGkjeIx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCkA/L8Gvouk7G1cURAmbKAJ93JOKR/nTu2GVYZgJ3LyYgkCLMjQCfaJB5
GfrU9P9M0XpLM020ojiFRAE=
=zzV+
-----END PGP SIGNATURE-----

--nextPart8168467.eIPcGkjeIx--

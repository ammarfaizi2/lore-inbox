Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVCIKVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVCIKVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVCIKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:21:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:8884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262270AbVCIKVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:21:06 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux 2.6.11.2
Date: Wed, 9 Mar 2005 11:21:14 +0100
User-Agent: KMail/1.7.2
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt> <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2401382.apS6LLvr4X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503091121.16801.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2401382.apS6LLvr4X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 March 2005 11:04, Geert Uytterhoeven wrote:
> On Wed, 9 Mar 2005, Marcos D. Marado Torres wrote:
> > On Wed, 9 Mar 2005, Greg KH wrote:
> > > which is a patch against the 2.6.11.1 release.  If consensus arrives
> > > that this patch should be against the 2.6.11 tree, it will be done th=
at
> > > way in the future.
> >
> > IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
> > againt
> > the last -rc but against 2.6.x.
>
> It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most
> logical to me.
>
> Gr{oetje,eeting}s,
>
> 						Geert

I don't think so. The latest patch (2.6.11.2 now) is on the frontpage of=20
kernel.org, so IMHO the user should not need to search the kernel.org/pub=20
archives to get 2.6.11.1 patch before he can start working with 2.6.11.2.

I think it's a small problem too, that 2.6.11 source isn't directly accessa=
ble=20
through the kernel.org frontpage while there is no "full tarball" of 2.6.11=
=2EX=20
trees.

greetings,
	dominik

--nextPart2401382.apS6LLvr4X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0-ecc0.1.6 (GNU/Linux)

iQCVAwUAQi7OHAvcoSHvsHMnAQIIvwP+Me0/BRJ+T8eeG8KarKAgZwEaLaX1/v9R
oGsuCybGHNs2p0rdftyYwHyiL9/H6TP0htkGozenOGCgH1NWMEaweADJgYr50/Ci
+SeiFZL9pPekEk8UHVwmH3n27c16EKvx3A3DmNROrfkW/ZwRlcg59Kd29+uyyHcl
tULimQuDNCU=
=2nXl
-----END PGP SIGNATURE-----

--nextPart2401382.apS6LLvr4X--

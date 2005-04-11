Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVDKAAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVDKAAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDKAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:00:53 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:26775 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261500AbVDKAAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:00:44 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: Kernel SCM saga..
Date: Mon, 11 Apr 2005 02:00:28 +0200
User-Agent: KMail/1.8
Cc: Daniel Phillips <phillips@istop.com>, Dmitry Yusupov <dima@neterion.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <200504071429.25073.phillips@istop.com> <20050410223330.GA26127@kalmia.hozed.org>
In-Reply-To: <20050410223330.GA26127@kalmia.hozed.org>
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2087152.fRpsJi00S4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504110200.31080.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2087152.fRpsJi00S4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 April 2005 12:33 am, you wrote:
[......]
> Well, I followed some of the instructions to mirror the kernel tree on
> svn.clkao.org/linux/cvs, and although it took around 12 hours to import
> 28232 versions, I seem to have a mirror of it on my own subversion
> server now. I think the svn.clkao.org mirror was taken from bkcvs... the
> last log message I see is "Rev 28232 - torvalds - 2005-04-04 09:08:33"

I'd love to see svk as a real choice for you guys, but I don't mind as alon=
g=20
as I get a door open using svn/svk ;);)

> I have no idea what's missing. What is everyone's favorite web frontend
> to subversion?=20

Check out ViewCVS at: http://viewcvs.sourceforge.net/
This seem widely used (not just by me ^o^).

Regards,
Christian Parpart.

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
 01:55:08 up 18 days, 15:01,  2 users,  load average: 0.27, 0.39, 0.36

--nextPart2087152.fRpsJi00S4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCWb4fPpa2GmDVhK0RAidhAJ93x79YCQNp/hAmTL75zN8s2hrW7gCffEYF
bUMXSPUhYLDFn3C+SZsLyxs=
=gp7N
-----END PGP SIGNATURE-----

--nextPart2087152.fRpsJi00S4--

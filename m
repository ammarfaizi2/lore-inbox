Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVCCNxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVCCNxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCCNxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:53:47 -0500
Received: from td9091b2a.pool.terralink.de ([217.9.27.42]:11770 "EHLO
	tolot.miese-zwerge.org") by vger.kernel.org with ESMTP
	id S261671AbVCCNxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:53:42 -0500
Date: Thu, 3 Mar 2005 14:52:15 +0100
From: Jochen Striepe <jochen@tolot.escape.de>
To: Massimo Cetra <mcetra@navynet.it>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel release numbering
Message-ID: <20050303135215.GT11280@tolot.miese-zwerge.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050303010615.3C7F184008@server1.navynet.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline
In-Reply-To: <20050303010615.3C7F184008@server1.navynet.it>
User-Agent: Mutt/1.4.2.1i
X-Signature-Color: brightblue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

    Hi,

On 03 Mar 2005, Massimo Cetra wrote:
> So, why moving from 2.6.14 to 2.6.15 when, in 2/4 weeks, i'll have a more
> stable 2.6.16 ?=20
> Will users help testing an odd release to have a good even release ? Or w=
ill
> they consider an even release as important as a -RC release ?

 From my experience this won't work (at least it won't work as inten-
ded). I see a tendency of people going away from Linux-2.6, going back
to Linux-2.4, or even going to one of the free BSD's. They go away
because they have the feeling they cannot rely any longer on the stabi-
lity of the 2.6 kernel branch (there are other issues, but this one is
common with most people I talked).

What you really need to avoid this (as far as I can see) is a stable
Kernel branch that does not give you a huge surprise every time you do
a kernel upgrade. Some mediocre statement like "this one might be quite
ok" is not enough -- you need to declare that 2.6.EVEN is *stable*, that
it is ready for production use. When people give it a test, fix the bugs
they find, and release anew without adding any other "improvements". This
way the user gets the least surprises when doing the next update -- and
that is what gets you more users on 2.6: the users will feel they can
*rely* on the stable releases.

At least that's how it looks here. And yes, I *know* it's harder to do
development when you're stuck with maintaining a stable branch. It's
your choice.


Greetings,

Jochen.
--=20
I worry about my child and the Internet all the time, even though she's too
young to have logged on yet.  Here's what I worry about.  I worry that 10 or
15 years from now, she will come to me and say "Daddy, where were you when
they took freedom of the press away from the Internet?"     -Mike Godwin

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQEVAwUBQicWj6rOdlPj1wR/AQKUdwf/WRzCVWTk5XwLnbrkFPIMghh/MqXwl3Ib
pkaSZuTUQ93RJ/taFhMJRpA2G2gP/EkY1Y/JFzQQ+Qrhy9CaUmVhGLKHHbX/iwJ8
lXTshi7FuL7LX166wtIWBDOBmp75+yCBA4OgwAI8Peh+ZmpojeCevevCXMVp4gpi
whtAuc2CHzpyH+dT4Z/KS0m1o1uYRpb1VTAbxSyDvEnOYmE5gkhvKBkh72HrP2ci
UaKclF7kIZYSDimETnN4Wgbjf9k2OfBRwiOeDDv2a1zjWHHGbNLrypXzjh48XRVX
ZydFZNcJdR1ZVtJy5FSSC5on/1F7NPksaHmFDIXPYsBzDg2/APjpqA==
=rA57
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--

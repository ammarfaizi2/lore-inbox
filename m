Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUKDCYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUKDCYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUKDCO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:14:56 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:12900 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262100AbUKDCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:09:10 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Uml: hostfs sendfile support
Date: Thu, 4 Nov 2004 03:09:03 +0100
User-Agent: KMail/1.7.1
Cc: nils toedtmann <user-mode-linux-user@nils.toedtmann.net>,
       user-mode-linux-user@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <20041102150339.GA6904@gandalf.intern.marcant.net> <200411032037.56892.blaisorblade_spam@yahoo.it> <20041104011116.GB5175@gandalf.intern.marcant.net>
In-Reply-To: <20041104011116.GB5175@gandalf.intern.marcant.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4893120.WOCtJdFSgr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411040309.18181.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4893120.WOCtJdFSgr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 02:11, nils toedtmann wrote:
> I cc this mail to user-mode-linux-devel and LKML, too. But as i do not
> subscribe to those lists it will probably get rejected. So you may
> want to forward it.
No need. LKML is open, and UML-devel follows that.

> > > > I don't remember at the moment.

> > So, if you want to use httpd, either don't use in on hostfs, or use it =
on
> > 2.4,

> That's what i did. It was my sole 2.4-uml ...

> > or recompile apache disabling the usage of sendfile(). This is a new
> > notice I get, however.

> > That said, there is a possibility the patch is just a one-liner. It see=
ms
> > there is generic support for this. Try the attached one. Report what
> > happens, please, so I know what to do with it. If it works, it will be
> > included in next release.

> Whoopy! It works.
Wonderful!
> Many thanks!

Ok, in this case, I'm going to include that in next release. Bye and thanks=
=20
for the report!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart4893120.WOCtJdFSgr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiY9OqH9OHC+5NscRAiZWAJ0Sn/j2+vi/uR+s/8N9vKw6GkyoXwCgiaUd
AFxEIV7gHchQN2lruJl7GU8=
=qz1x
-----END PGP SIGNATURE-----

--nextPart4893120.WOCtJdFSgr--

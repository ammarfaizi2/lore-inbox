Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTGCSWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTGCSWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:22:55 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:5856
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265234AbTGCSWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:22:53 -0400
Date: Thu, 3 Jul 2003 11:37:16 -0700
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New fbdev updates.
Message-ID: <20030703183716.GA19216@triplehelix.org>
References: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, Jul 03, 2003 at 06:55:58PM +0100, James Simmons wrote:
>=20
> Hi!
>   =20
>    I have updates to the framebuffer layer. Alot of bug fixes accumlated.=
=20
> A couple of driver updates as well. I have more code to go in but haven't=
=20
> had time to add them in. Please test. This is not the final code going in=
=20
> just yet. More needs to be done. The patches are at the usual
>=20
>     http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

I was wondering whether you are working on the radeonfb issue in 2.5
since forever that there is a lot of multicolored garbage on the screen
initially when the kernel starts, and the first clear text seen are ACPI
notices. Is it an issue of transferring what was written to the display
in raw mode to the FB? The 2.4 radeonfb driver does not have this
issue.

This is one of the last things on my 2.5 wishlist for me, I'll die a
happy man if you can fix it :)

-Josh

--=20
"Notice that, written there, rather legibly, in the Baroque style common=20
to New York subway wall writers, was, uhm... was the old familiar=20
suggestion. And rather beautifully illustrated, as well..."

       -- Art Garfunkel on the inspiration for "A Poem On The Underground W=
all"

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BHfbT2bz5yevw+4RAoSOAJ0TclM111ccO3sMJK4n5qszrLIg3gCfeA/P
1YBvevZogMGtPM8OB+1Mqh4=
=A3am
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

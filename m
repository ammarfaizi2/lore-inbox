Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbUKLCUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUKLCUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 21:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbUKLCUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 21:20:12 -0500
Received: from zlynx.org ([199.45.143.209]:17158 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262378AbUKLCTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 21:19:52 -0500
Subject: Re: Reiser{3,4}: problem with the copyright statement
From: Zan Lynx <zlynx@acm.org>
To: Stephen Pollei <stephen_pollei@comcast.net>
Cc: Adrian Bunk <bunk@stusta.de>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1100213504.8355.27.camel@fury>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <20041111214554.GB2310@stusta.de>  <1100213504.8355.27.camel@fury>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XoqthebYfgFLEIE31DQ8"
Date: Thu, 11 Nov 2004 19:08:12 -0700
Message-Id: <1100225292.16114.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XoqthebYfgFLEIE31DQ8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-11-11 at 14:51 -0800, Stephen Pollei wrote:
> On Thu, 2004-11-11 at 13:45, Adrian Bunk wrote:
> > If you add your code to governed files, and don't
> > want it to be owned by Hans Reiser, put your copyright label on that
> > code ... All portions of governed files not labeled otherwise are owned
> > by Hans Reiser, and ... and leaving the sentence in stating that
> > licensing is governed by the statement in this file, you accept this.
>=20
> > Besides the fact that giving the copyright completely away is nothing=20
> > that is legally possible in at least Germany, ...
>=20
> Han's method is also very likely nugatory within the USA.
>=20
> http://copyright.gov/title17/92chap2.html#204 clearly states that to
> transfer title of copyrighted work requires a written instrument of
> conveyance. That instrument of conveyance has to be signed and should in
> many ways look a lot like a deed or title for real estate -- ie. it must
> denote the boundaries of the transaction in a specific and explicit
> manner. In this instance it would probably be required to state in as
> unambiguous manner as possible which files and which versions this
> transfer is to cover. In the case of patches to preexisting files; it
> should also be specific as to which lines are to be covered unless one
> writes it in a style like a "Quit Claim Deed".

(not a lawyer, etc, etc.  Just a LKML lurker.)

As I understand it, these things depend on the size of the changes.  For
example, in the world of publishing, an editor may change spellings and
phrases, even add or remove entire paragraphs, but does not gain any
rights over the work by doing so.

If there was argument about this, deciding where the line is between a
edit and new work would be up to a court, no doubt.  If I was deciding
it, changes to fit ReiserFS into a new VFS structure or fixing a locking
bug would be a "edit", while adding a new Reiser4 plugin or a more
efficient hash function would be "new work."
--=20
Zan Lynx <zlynx@acm.org>

--=-XoqthebYfgFLEIE31DQ8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBlBsMG8fHaOLTWwgRAgoqAJ9LOlm9do0VDxQK3x1dNl1vzjAKmACdFwHw
mEvGRARgFshv3j3AQs8hBuM=
=te22
-----END PGP SIGNATURE-----

--=-XoqthebYfgFLEIE31DQ8--


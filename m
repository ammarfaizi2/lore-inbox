Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbUJ0Q3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUJ0Q3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUJ0Q2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:28:22 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:10708 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S262505AbUJ0QRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:17:33 -0400
Date: Wed, 27 Oct 2004 18:14:02 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: [OT] Re: The naming wars continue...
Message-ID: <20041027161402.GC21160@thundrix.ch>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch> <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Oct 27, 2004 at 06:11:43PM +0200, Grzegorz Kulewski wrote:
> Yes, Linux (or UNIX) directory structure should be changed years ago but=
=20
> nobody (except GOBO Linux I think) is going to do it. That will require=
=20
> patching realy big amount of code and changing some standards. If somebod=
y=20
> has time for it feel free to contact me, and I will tell him (or her) wha=
t=20
> should be changed to produce The New Directory Standard That Breaks=20
> Everything But Is The Best And Most Sane In The World (TM)... :-)

This is not the case, thanks  to autoconf and pkg-config. On one of my
systems, I have all the  binaries under /Library/..., and all the libs
under     /Frameworks/...,     and      the     doc     goes     under
/Library/Documentation/someplace...

It's not a problem any more, thanks to the ongoing modularization.

			    Tonnerre


--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBf8lJ/4bL7ovhw40RAl+0AJwKBGhCg41DKHL3qbM2iFQhHRPoCgCgh2g8
yIFQgBOzTc1FuOOtkZl7hdU=
=mGMZ
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWADNSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWADNSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWADNSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:18:13 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:58279 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751252AbWADNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:18:12 -0500
Date: Wed, 4 Jan 2006 14:18:05 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ben Slusky <sluskyb@paranoiacs.org>, Steven Rostedt <rostedt@goodmis.org>,
       linux-fsdevel@vger.kernel.org, legal@lists.gnumonks.org,
       "Robert W. Fuller" <garbageout@sbcglobal.net>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, info@crossmeta.com
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20060104131805.GM4898@sunbeam.de.gnumonks.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <20051223153541.GA13111@paranoiacs.org> <20060104110929.GH4898@sunbeam.de.gnumonks.org> <20060104115422.GA2562@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline
In-Reply-To: <20060104115422.GA2562@mail.shareable.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2006 at 11:54:22AM +0000, Jamie Lokier wrote:
> Harald Welte wrote:
> > > The case here appears to be:
> > >=20
> > > * Crossmeta offers "add-on" software as a free download from their web
> > >   site: <URL:http://www.crossmeta.com/downloads/crossmeta-add-1_0.zip=
>.
> > >   The zip file contains a text file gpl-license.txt, which says that =
the
> > >   add-ons are offered under the terms of the GPL.
> > >=20
> > > * User downloads this GPLed software and asks the developer to provide
> > >   source code. Developer replies that the source code will be provided
> > >   only to paying customers:
> > >   <URL:http://www.opensolaris.org/jive/message.jspa?messageID=3D12277=
#12277>.
> > >=20
> > > That's baad, m'kay?
> >=20
> > This is definitely not acceptable.  A written offer must be valid to ANY
> > 3RD PARTY. =20
> >=20
> > So it wouldn't even be enough to offer the source code to paying
> > customers and those who downloaded the binary code, but actually it must
> > be made available to anyone who asks for it.
>=20
> Ah, that depends on whether they provided the source code for download
> to paying customers at the time those customers downloaded the binary.

yes.  but the point is (according to reports I have received) that the
object code (without source code) was available for download on the
crossmeta website.=20

Therefore anyone could have obtained a binary copy with no included
source code, and thus the 'any third party' clause implicitly comes into
effect.

As soon as you've even only once given a copy of the executable code
without at the same time including the full corresponding source code,
"any third party" is entitled to obtain a copy of the source code.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDu8sNXaXGVTD0i/8RAtmxAJ979JpxdWHjCxD6TJpMMDuczuB7QQCfTujp
uuhFz/4SJV9rCGcARqiVU90=
=i6K4
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--

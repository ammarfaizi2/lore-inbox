Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262863AbSJLJ0W>; Sat, 12 Oct 2002 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbSJLJ0W>; Sat, 12 Oct 2002 05:26:22 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:19950 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262863AbSJLJ0V>; Sat, 12 Oct 2002 05:26:21 -0400
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: Ole Husgaard <osh@sparre.dk>
Cc: bidulock@openss7.org, Christoph Hellwig <hch@infradead.org>,
       David Grothe <dave@gcom.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       Dave Miller <davem@redhat.com>
In-Reply-To: <3DA78926.FB2299A@sparre.dk>
References: <5.1.0.14.2.20021010115616.04a0de70@localhost>
	<4386E3211F1@vcnet.vc.cvut.cz>
	<5.1.0.14.2.20021010115616.04a0de70@localhost>
	<20021010182740.A23908@infradead.org>
	<5.1.0.14.2.20021010140426.0271c6a0@localhost>
	<20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org> 
	<3DA78926.FB2299A@sparre.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2KCdChk/P4OXXrscL9Zb"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 11:32:21 +0200
Message-Id: <1034415141.2962.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2KCdChk/P4OXXrscL9Zb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-10-12 at 04:29, Ole Husgaard wrote:
> "Brian F. G. Bidulock" wrote:
> > On Fri, 11 Oct 2002, Christoph Hellwig wrote:
> > > It is not.  Sys_call_table was exported to allow iBCS/Linux-ABI
> >=20
> > I don't know if it matters, but these two calls putpmsg and getpmsg
> > are the calls used by iBCS.
>=20
> AFAIK, iBCS use these syscalls to emulate TLI, and iBCS
iBCS doesn't exist for 2.4 or 2.5 kernels
it's called linux-abi now and does NOT use these syscalls


--=-2KCdChk/P4OXXrscL9Zb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9p+wkxULwo51rQBIRAosLAKCprC2k6phFFTNfuVEleV5P/GrUNACgkeQ9
Dp2qE1M0u7WyjshO2i4FThI=
=2lUi
-----END PGP SIGNATURE-----

--=-2KCdChk/P4OXXrscL9Zb--


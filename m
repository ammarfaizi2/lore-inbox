Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSAZIno>; Sat, 26 Jan 2002 03:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSAZIn2>; Sat, 26 Jan 2002 03:43:28 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:45980 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S288956AbSAZInP>; Sat, 26 Jan 2002 03:43:15 -0500
Date: Sat, 26 Jan 2002 03:43:11 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-ID: <20020126084311.GA1530@opeth.ath.cx>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2002 at 12:40:00AM -0800, Andrew Morton wrote:
> I'd be interested in feedback from testers, please.

_Wonderful_ patch. I've been testing for the past hour or so on my
Yamaha CRW2200E (hooked up to hdc, ide1, on VIA vt82c686b (rev 40)), and
the cpu load has rarely peaked 7-9% with cdparanoia.

I have not had a chance to test with a SCSI reader yet because my local
patchset has some unresolved symbols in a scsi module, but I expect to
iron those out shortly.

Thanks again, Andrew.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8UmwfMwVVFhIHlU4RApCAAJ9h4Ye4ooMuc/CENwNF6cynEOaG6QCfYfIe
nIQ+7FbCjLZHNyH1tCgIcaw=
=4J8j
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

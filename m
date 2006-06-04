Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750745AbWFDRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFDRBk (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 13:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFDRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 13:01:39 -0400
Received: from nsm.pl ([195.34.211.229]:44824 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750745AbWFDRBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 13:01:39 -0400
Date: Sun, 4 Jun 2006 19:01:35 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request at virtual address feededed (was: Re: Linux v2.6.17-rc5)
Message-ID: <20060604170135.GA7306@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org> <20060528182342.GA9433@irc.pl> <Pine.LNX.4.64.0605301132180.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605301132180.5623@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2006 at 11:44:03AM -0700, Linus Torvalds wrote:
> On Sun, 28 May 2006, Tomasz Torcz wrote:
> >
> >   After 2 days and few hours uptime, during updatedb run I got:
> >=20
> > BUG: unable to handle kernel paging request at virtual address feededed
>=20
> I don't see anything suspicious anywhere, and this doesn't ring a bell.=
=20
> It is probably a good idea to open a bugzilla entry on it, so that it=20
> doesn't get lost.

  Filed as http://bugzilla.kernel.org/show_bug.cgi?id=3D6641

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEgxHvThhlKowQALQRAhxDAKCNanIZFvLyDE+WhXXkWZPutCv4LQCfbj2s
d4M0P/m2CQKwqr/gf3oYfFE=
=LXua
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUGITr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUGITr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGITr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:47:57 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:8662 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S265508AbUGITry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:47:54 -0400
Date: Fri, 9 Jul 2004 21:47:53 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709194753.GB11138@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709120336.74e57ceb.akpm@osdl.org> <20040709192253.GA11138@wavehammer.waldi.eu.org> <20040709123005.086fdfc5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20040709123005.086fdfc5.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2004 at 12:30:05PM -0700, David S. Miller wrote:
> On Fri, 9 Jul 2004 21:22:53 +0200
> Bastian Blank <bastian@waldi.eu.org> wrote:
>=20
> > The original submission is recorded on
> > http://marc.theaimsgroup.com/?l=3Dlinux-net&m=3D104551077013011&w=3D2. =
And the
> > complaint was that it puts '"ipv6 stuff" into the generic netdevice
> > structure'. I don't know if this can be solved another way.
>=20
> Put it in the inet6device private area.

Where is it declared?

> It's been a year, and you haven't put forth the effort to look
> for solutions like that?

Err, I'm not the submitter of the original patch. I just wanted to have
the feature which needs that code marked as broken.

Bastian

--=20
Beam me up, Scotty!

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkDu9mkACgkQnw66O/MvCNE8DgCdGibQ3nnqV2jt+WUMLQnNbR0m
P7cAoJ6AUcUcZ8IMDvYKLfWgCxsqH9yl
=+O69
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

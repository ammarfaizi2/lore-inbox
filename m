Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWJHReu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWJHReu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJHReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:34:50 -0400
Received: from lug-owl.de ([195.71.106.12]:44772 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751292AbWJHRet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:34:49 -0400
Date: Sun, 8 Oct 2006 19:34:46 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008173445.GN30283@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	linux-kernel@vger.kernel.org
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com> <20061008045522.GG29474@stusta.de> <1160283948.10192.3.camel@lade.trondhjem.org> <20061008063943.GB6755@stusta.de> <84144f020610080045s6d2d1b06o6fc78bfb8fbf4d77@mail.gmail.com> <20061008172859.GD6755@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GAVKUSgG5XxJefcs"
Content-Disposition: inline
In-Reply-To: <20061008172859.GD6755@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GAVKUSgG5XxJefcs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 19:28:59 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Oct 08, 2006 at 10:45:50AM +0300, Pekka Enberg wrote:
> > On Sun, Oct 08, 2006 at 01:05:48AM -0400, Trond Myklebust wrote:
> > >> In any case, what the fuck gives you the right to appoint yourself j=
udge
> > >> and jury over kernel regressions?
> >=20
> > On 10/8/06, Adrian Bunk <bunk@stusta.de> wrote:
> > >I've given this right myself - everyone can always send any bug list he
> > >wants to linux-kernel.
> >=20
> > I don't see what the problem here is. As stated in the bug report, a
> > patch signed off by you broke something in the kernel which is not yet
> > fixed in -git. Aside from calling people "guilty", what Adrian is
> > doing is a service to us all.
>=20
> It seems the word "Guilty" was considered offensive by some people?

I'd find it offensive, too, when I'd be called "guilty" because a
patch broke something that was buggy. Read the bug report: Seems it
was actually caused by a non-initialized variable introduced by a
patch to util-linux.

> This wasn't my intention, and I've replaced it with "Caused-By".

Made-visible-by :)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
 Signature of:                            If it doesn't work, force it.
 the second  :                   If it breaks, it needed replacing anyway.

--GAVKUSgG5XxJefcs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKTa1Hb1edYOZ4bsRAs+7AKCR8LEy6Oe4StMeYJ06351AAk/iqwCgkUZ+
RVrgIHe+MuU9+mndHqF2+sc=
=KsGB
-----END PGP SIGNATURE-----

--GAVKUSgG5XxJefcs--

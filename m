Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVC2IJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVC2IJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVC2HYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:24:43 -0500
Received: from dea.vocord.ru ([217.67.177.50]:22205 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262460AbVC2HED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:04:03 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Greg KH <greg@kroah.com>
Cc: Paul Jackson <pj@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050329070201.GA9983@kroah.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
	 <20050329070201.GA9983@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zBBMOirqde/5jtkFNELC"
Organization: MIPT
Date: Tue, 29 Mar 2005 11:10:09 +0400
Message-Id: <1112080209.5243.26.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 11:03:34 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zBBMOirqde/5jtkFNELC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-28 at 23:02 -0800, Greg KH wrote:
> On Tue, Mar 29, 2005 at 11:04:16AM +0400, Evgeniy Polyakov wrote:
> > On Mon, 2005-03-28 at 13:42 -0800, Paul Jackson wrote:
> > > I don't see it in my copies of *-mm or recent Linus bk trees.  Am I
> > > missing something?
> >=20
> > It was dropped from -mm tree, since bk tree where it lives=20
> > was in maintenance mode.
> > I think connector will be appeared in the next -mm release.
>=20
> Should have been in the last -mm release.  If not, please let me know.

Thank you.
If you are not going to sleep right now I will recreate rejected
NLMSGSPACE
patch in a several minutes.

> thanks,
>=20
> greg k-h
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-zBBMOirqde/5jtkFNELC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSP9RIKTPhE+8wY0RArDBAJ0QqqGKiSBDVBjFTGgEaiYSXKOJogCfT+s/
iNnBjJeUKUvUkp+KIwD8GTI=
=7Pj+
-----END PGP SIGNATURE-----

--=-zBBMOirqde/5jtkFNELC--


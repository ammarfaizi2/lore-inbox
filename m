Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTJVTiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTJVTiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:38:51 -0400
Received: from codepoet.org ([166.70.99.138]:29670 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263539AbTJVTiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:38:50 -0400
Date: Wed, 22 Oct 2003 13:38:50 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
Message-ID: <20031022193849.GA21188@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0310070757400.4688-100000@sundance.cse.ucsc.edu> <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il> <20031022045708.GA5636@codepoet.org> <200310221605.h9MG5k37007196@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <200310221605.h9MG5k37007196@turing-police.cc.vt.edu>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed Oct 22, 2003 at 12:05:46PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 21 Oct 2003 22:57:09 MDT, Erik Andersen said:
>=20
> > Suppose I install srfs on both my laptop and my server.  I then
> > move the CVS repository for my pet project onto the new srfs
> > filesystem and I take off for the weekend with my laptop.   Over
> > the weekend I commit several changes to file X.  Over the weekend
> > my friend also commits several changes to file X.
> >=20
> > When I get home and plug in my laptop, presumably the caching
> > daemon will try to stabalize the system by deciding which version
> > of file X was changed last and replicating that latest version. =20
>=20
> Hey Larry - potential BitKeeper customer here. :)

Not so much a potential BitKeeper customer, as pointing out that
the distributed filesystems prople are attacking the same
fundamental problem as the distributed version control folks.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ltzJX5tkPjDTkFcRAoMHAKCWvts+GH7v/v4Hze9ERs0/YaIObACgwgEE
Zbm69ed+AmOYG/TITR1Pmnk=
=4UZC
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTEPS5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTEPS5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:57:24 -0400
Received: from www.hostsharing.net ([212.42.230.151]:57254 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S264590AbTEPS5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:57:22 -0400
Date: Fri, 16 May 2003 21:11:43 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb and high mem
Message-ID: <20030516191143.GA669@gandalf.home.lxtec.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030515194118.GA696@gandalf.home.lxtec.de> <20030516083939.GB1687@deimos.one.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20030516083939.GB1687@deimos.one.pl>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2003 the mental interface of=20
Damian Ko?kowski told:

> On Thu, May 15, 2003 at 09:41:18PM +0200, Elimar Riesebieter wrote:
> > I am running 2.4.21.rc2-ac2 with 1 GB RAM. The radeonfb can't map
> > FB. If I boot with mem=3D840MB the framebuffer runs. I thought it will
> > be fixed with the vesa_highmem fix but isn't with vesafb at all. The
> > same happens with noacpi ;-) The RAM is tested as good with memtest!
>=20
> Use that:
> 	http://gate.crashing.org/~ajoshi/radeonfb-0.1.8.diff.gz

radeonfb works only at mem=3D840 or less ;-)

Ciao

Elimar

--=20
  >what IMHO then?
  IMHO - Inhalation of a Multi-leafed Herbal Opiate ;)
              --posting from alex in debian-user--

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+xTfv3Ig8bsVPf7ARAiqoAJ9mxlDDVXcrF97a2bj9OwIOqsU86wCgiq5k
3chbCqiewb9FRrscoWHLpQU=
=p8ag
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

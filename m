Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUHKW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUHKW1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUHKW1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:27:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:62116 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268285AbUHKW0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:26:47 -0400
Date: Thu, 12 Aug 2004 00:22:13 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040811222213.GB14744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Chris Wright <chrisw@osdl.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040810130009.P1924@build.pdx.osdl.net> <Xine.LNX.4.44.0408101607170.9332-100000@dhcp83-76.boston.redhat.com> <20040810131217.Q1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20040810131217.Q1924@build.pdx.osdl.net>
X-Operating-System: Linux 2.6.7-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2004 at 01:12:17PM -0700, Chris Wright wrote:
> * James Morris (jmorris@redhat.com) wrote:
> > On Tue, 10 Aug 2004, Chris Wright wrote:
> > > Is this new (i.e. you just did this)?  It's basically the same result=
 we
> > > had from a few years ago.
> >=20
> > Yes, did it today.
>=20
> Thanks, James.  Since these are the only concrete numbers and they are
> in the noise, I see no compelling reason to change to unlikely().

Well, you may want to drop the unlikely if you dislike it.
The rest of the path is still a win IMVHO.

Unfortunately, it has not been discussed here yet.

Reards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBGpwVxmLh6hyYd04RAnCuAKDFiuBtglAKMSwHZFYxgm1xWcdDwACcCUZc
RhX+z/x2qfrWI6YyU9AgnV8=
=A03o
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272907AbTG3ONy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTG3OLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:11:43 -0400
Received: from coruscant.franken.de ([193.174.159.226]:49295 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272893AbTG3OLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:11:34 -0400
Date: Wed, 30 Jul 2003 16:08:13 +0200
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-ID: <20030730140813.GC4553@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20030726200646.GF16160@louise.pinerecords.com> <20030727160942.647707d8.davem@redhat.com> <20030729042618.GL32673@louise.pinerecords.com> <20030729223802.1d670476.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20030729223802.1d670476.davem@redhat.com>
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Sweetmorn, the 65th day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

On Tue, Jul 29, 2003 at 10:38:02PM -0700, David S. Miller wrote:
> On Tue, 29 Jul 2003 06:26:18 +0200
> Tomas Szepe <szepe@pinerecords.com> wrote:
>=20
> > The only aim of the patch is to put most netfilter options
> > in a dedicated submenu so that one can go tweaking the
> > them right where they've enabled netfilter in the first
> > place.
>=20
> This looks fine to me.  Can I get an ACK from the netfilter
> folks?

I also aggree with this change, please apply Tomas' second proposed
patch.

> Thanks.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J9FNXaXGVTD0i/8RAgtSAKCXXTZ3sxNgioEwFGKt/jH5FtLObACgmmvD
Z8OgKqwymYGbEUa4KPoJdGA=
=d3zh
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

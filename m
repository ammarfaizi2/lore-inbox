Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbTFARiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTFARiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:38:16 -0400
Received: from adsl-66-136-200-10.dsl.austtx.swbell.net ([66.136.200.10]:2944
	"EHLO dragon.taral.net") by vger.kernel.org with ESMTP
	id S264685AbTFARiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:38:14 -0400
Date: Sun, 1 Jun 2003 12:51:38 -0500
From: Taral <taral@taral.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modular IDE completely broken
Message-ID: <20030601175138.GA1936@taral.net>
References: <20030601055414.GA11218@taral.net> <20030601113050.GE27692@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20030601113050.GE27692@louise.pinerecords.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2003 at 01:30:50PM +0200, Tomas Szepe wrote:
> > [taral@taral.net]
> >=20
> > I've submitted this patch before, but I think it got ignored. This makes
> > modular IDE at least compile and removes the circular dependencies.
> >=20
> > If there's a reason this patch isn't being applied (it's crappy, someone
> > else is working on this problem already, etc.), _please_ tell me!
>=20
> Alan Cox is working on the problem ATM, check 2.4.21-rc6-ac1.

Is this work for 2.5 as well? My patch is against 2.5.69.

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Most parents have better things to do with their time than take care of
their children." -- Me

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2j0poQQF8xCPwJQRAhBRAJ9lFA93dLqK8jXNZNoaGTyc2AUtxgCfaJ5v
DKjmyNXxGYgh9tvIdpCz5N8=
=3Jxc
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

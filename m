Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTL3Jg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTL3Jg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:36:56 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:33699 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261879AbTL3Jgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:36:54 -0500
Date: Tue, 30 Dec 2003 11:36:43 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "Sirotkin, Alexander" <demiurg@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: network driver that uses skb destructor
Message-ID: <20031230093642.GA23643@actcom.co.il>
References: <3FF05C27.5030706@ti.com> <20031229172402.GG13481@actcom.co.il> <1072775631.6557.11.camel@newt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <1072775631.6557.11.camel@newt>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2003 at 09:13:50AM +0000, Adrian Cox wrote:

> It's interesting to me, for my work with PCI backplane networking, as it
> would eliminate an extra packet copy on receive.

Ok. The patch is fairly old and bitrotted, so it will take me a few
days to resurrect it to reasonable 2.6.x levels.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8UcpKRs727/VN8sRAnzkAJ9XmhLinU9+797Y1bErgq4DAzgNxwCfVNvJ
dPI1dPUN4eIH5JkxPQTvWeM=
=gVNo
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

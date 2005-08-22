Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVHVWJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVHVWJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVHVWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:09:51 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:59920 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750812AbVHVWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:09:50 -0400
Date: Tue, 23 Aug 2005 00:07:56 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: brian@visionpro.com
Subject: Re: Binding a thread (or specific process) to a designated CPU
Message-ID: <20050822220756.GA20694@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org, brian@visionpro.com
References: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2005 at 02:56:47PM -0700, Brian D. McGrew wrote:
> Using FC3 or FC4 with the 2.6.9 or later kernel, we're looking for a way
> to bind a thread (or an entire process) to a designated CPU.=20

 man sched_setaffinity

--=20
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na =BFycie maj=B1 tu patenty spe=
cjalne.


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDCky8ThhlKowQALQRAiDHAKCkVxnn+ndZhdCdZwSIN2QWw0y9UgCfcI19
l0Ks672p2II8U4teRP+WDh0=
=ctC0
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

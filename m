Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJIIUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJIIUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:20:32 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:55723 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261929AbTJIIUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:20:31 -0400
Date: Thu, 9 Oct 2003 10:20:20 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.6.0-test7 no sound and OOPS
Message-ID: <20031009082020.GA3611@actcom.co.il>
References: <200310082321.02406.dreher@math.tu-freiberg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <200310082321.02406.dreher@math.tu-freiberg.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2003 at 11:21:02PM +0200, Michael Dreher wrote:

>  [<c03371df>] snd_pcm_oss_sync+0x6f/0x170
>  [<c03387b3>] snd_pcm_oss_release+0x23/0xe0
>  [<c0338790>] snd_pcm_oss_release+0x0/0xe

Fix exists in ALSA CVS, needs to be pushed to Linus... (hint hint)=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hRpEKRs727/VN8sRAp/GAJ9Cd4GJHMK1OtufJKezONDOnQ5aeQCcDyqF
s0Y25tNouY2Rdwgw8PxIgy4=
=GqLO
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

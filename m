Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbUDGIJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUDGIJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:09:40 -0400
Received: from gemini.rz.uni-ulm.de ([134.60.246.16]:11492 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP id S264139AbUDGIJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:09:37 -0400
Date: Wed, 7 Apr 2004 10:00:50 +0200
From: Juergen Salk <juergen.salk@gmx.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strip whitespace from EXTRAVERSION?
Message-ID: <20040407080050.GA25009@oest181.str.klinik.uni-ulm.de>
References: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de> <yw1xwu4tneyc.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <yw1xwu4tneyc.fsf@kth.se>
User-Agent: Mutt/1.3.28i
X-DCC-RollaNet-Metrics: gemini 1004; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* M=E5ns Rullg=E5rd <mru@kth.se> [040406 20:23]:

> good idea in case the EXTRAVERSION should contain shell
> meta-characters.  Why anyone would do such a thing is beyond my
> imagination, ...=20

I concur. But you don't even need meta-characters to mess up the
whole system with a badly or just carelessly formatted
EXTRAVERSION.=20

Imagine what may happen with something like:

EXTRAVERSION =3D -foo / # my homebrew -foo kernel

Maybe somewhat far-fetched ...

> ... but who knows?

True.

Best regards - Juergen

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAc7UyvQ1LM6mXunoRAsuGAJ9U1QyApUPO8V9n7pmjT3Xy2etoHACgnN48
3dmv0aj0BoM7UHMnJvf2qhU=
=EYau
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

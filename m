Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTDATAl>; Tue, 1 Apr 2003 14:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbTDATAl>; Tue, 1 Apr 2003 14:00:41 -0500
Received: from B583e.pppool.de ([213.7.88.62]:17567 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262780AbTDATAi>; Tue, 1 Apr 2003 14:00:38 -0500
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
From: Daniel Egger <degger@fhm.edu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401162615.GA1131@suse.de>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com>
	 <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
	 <1049191863.30759.3.camel@averell> <20030401112800.GA23027@suse.de>
	 <1049197774.31041.15.camel@averell>
	 <Pine.LNX.4.50.0304011105540.8773-100000@montezuma.mastecende.com>
	 <20030401162615.GA1131@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4CxJrS4uMq0jU8VooEAj"
Organization: 
Message-Id: <1049221861.2643.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 20:31:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4CxJrS4uMq0jU8VooEAj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-04-01 um 18.26 schrieb Dave Jones:

> I'm not 100% sure on this, but I *think* 3dnow had an sfence which was
> opcode compatable with SSE's instruction.

At best the enhanced 3dnow had it. I couldn't find it in the regular
3dnow "technology manual" and don't know where I put the darn other
one....

--=20
Servus,
       Daniel

--=-4CxJrS4uMq0jU8VooEAj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+idrkchlzsq9KoIYRAmBKAJ9LeVyG0ZtxF5L84plfHEphj4ibDQCfeJg/
C2D+zdB2WGCWQ4Aquh/RHUk=
=LhNS
-----END PGP SIGNATURE-----

--=-4CxJrS4uMq0jU8VooEAj--


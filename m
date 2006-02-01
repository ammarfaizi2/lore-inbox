Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422865AbWBASjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422865AbWBASjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWBASjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:39:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12988 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422865AbWBASje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:39:34 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, chris perkins <cperkins@OCF.Berkeley.EDU>
In-Reply-To: <1138818770.6685.1.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VgcoxbPt/I5aciRx3TUT"
Date: Wed, 01 Feb 2006 12:39:02 -0600
Message-Id: <1138819142.18762.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VgcoxbPt/I5aciRx3TUT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 at 13:32 -0500, Steven Rostedt wrote:
>=20
> I'm still curious to what's happening with your kernel.  I'm currently
> running my x86_64 (typing right now on it) with CONFIG_SMP=3Dn and
> CONFIG_LATENCY=3Dy.  I know you probably sent a config before, but could
> you send it to me again.  (probably best to send it to me off list)

yeah, it's been gnawing at me too. Not really stopping me, but I've seen
it happen on two Athlon64's (3000+ and 3400+).=20

I'll send the .config offlist.

Clark

--=20
Clark Williams <williams@redhat.com>

--=-VgcoxbPt/I5aciRx3TUT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4QBGHyuj/+TTEp0RAkC2AJ9D65GHHoIPZzPezjol2WeWaVkU7ACgzp1H
+t6qHOiY2zA0nmlF8eVKNZM=
=DFi/
-----END PGP SIGNATURE-----

--=-VgcoxbPt/I5aciRx3TUT--


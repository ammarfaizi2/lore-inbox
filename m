Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTFLH4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTFLH4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:56:49 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:51950 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263542AbTFLH4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:56:47 -0400
Subject: Re: Linux 2.4.21-rc8
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612.6274686@knigge.local.net>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva>
	 <20030610165622.A17342@google.com>
	 <Pine.LNX.4.55L.0306102109340.30401@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0306111815100.31893@freak.distro.conectiva>
	 <20030612.6274686@knigge.local.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y6oaKkFYgICi8exS/7x4"
Organization: Red Hat, Inc.
Message-Id: <1055405396.5785.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 12 Jun 2003 10:09:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y6oaKkFYgICi8exS/7x4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-06-12 at 08:27, Michael Knigge wrote:

>=20
> Hmmm... I don't want to tell you how you have to do your job, but this=20
> is a known error and (if I followed the postings here correctly) there=20
> was a fix posted. So why not include it in 2.4.22?

If you wait with releases until every last and final bug is fixed,
you'll never get a release out, because there is always SOME bug
somewhere left, the kernel is just too big for that to not be the case.
It's a matter of priorities if a defect is a stopship  or not, and it
seems the bug in question isn't according to the release managers
opinion.=20


--=-y6oaKkFYgICi8exS/7x4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+6DVUxULwo51rQBIRArLrAKCUxdtDPjGvt2x3+fo2nNHsW0kKNACggJ9S
5wU1jZpung7KM7LReGfK0GE=
=1s8v
-----END PGP SIGNATURE-----

--=-y6oaKkFYgICi8exS/7x4--

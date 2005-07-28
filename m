Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVG1BW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVG1BW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVG1BWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:22:25 -0400
Received: from hostmaster.org ([212.186.110.32]:4568 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S261478AbVG1BV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:21:56 -0400
Subject: Re: 2.6.12: no sound on SPDIF with emu10k1
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1122497052.22844.5.camel@mindpipe>
References: <1122493585.3137.14.camel@hostmaster.org>
	 <1122497052.22844.5.camel@mindpipe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1lXTijUwl1Z5qDUshl5h"
Date: Thu, 28 Jul 2005 03:21:55 +0200
Message-Id: <1122513715.13792.22.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-1.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1lXTijUwl1Z5qDUshl5h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-07-27 at 16:44 -0400, Lee Revell wrote:
> On Wed, 2005-07-27 at 21:46 +0200, Thomas Zehetbauer wrote:
> > I cannot get my SB Live! 5.1's SPDIF (digital) output to work with
> > kernel > 2.6.12. I have not changed my mixer configuration and it is
> > still working when I boot 2.6.11.12 or earlier. I am using FC4 with
> > alsa-lib-1.0.9rf-2.FC4 installed.
>=20
> FC4 shipped a buggy ALSA version, I can't believe there are no updated
> RPMs yet.
>=20
> You need a newer ALSA.

alsa-lib-1.0.9rf-2 is the latest update available:
http://download.fedora.redhat.com/pub/fedora/linux/core/updates/4/x86_64/al=
sa-lib-1.0.9rf-2.FC4.x86_64.rpm

If FC4's ALSA was really broken, I wonder why it is working fine with
kernel 2.6.11.12 and earlier?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Chaos is the only form of life, order was caused by the Nazis and millions =
died!




--=-1lXTijUwl1Z5qDUshl5h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQugzM2D1OYqW/8uJAQKacwf+KQgtWmkI+7Al7oV/xiSVYiPh0IZbFCYq
pIKAWeNyXdKCWLAkPWhg87grrjyQjzxehzaJVReee98SeaFFMuSy9DwAzFA8t2Jm
1MnZC5eIM8UPJtQ6qP3c3WtV2VPjudtMf5VeINbDB0AzTW/CbLuXjXxKyQl2YgU+
pnbtKJMz97PaooiJ7yp1Lc/42WVMhqEPvha7oHqM3JyOEvzLnLjCTvcZMaYisVyw
f3UqRxjnJL0Dzg6s16mx1Cog5u5/zah/1jJOHCXMGevusTN03XdFJbMCDWLHYkfz
FhcVzXwgZ5GtnMdvRJgUefHRLPOnyZEQKTYIbuzwcR5yc6z8U34apA==
=YFyr
-----END PGP SIGNATURE-----

--=-1lXTijUwl1Z5qDUshl5h--


Return-Path: <linux-kernel-owner+w=401wt.eu-S1161148AbWLUCW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWLUCW3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWLUCW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:22:29 -0500
Received: from smtp.rutgers.edu ([128.6.72.243]:30495 "EHLO
	annwn14.rutgers.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161148AbWLUCW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:22:29 -0500
From: Michael Wu <flamingice@sourmilk.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Network drivers that don't suspend on interface down
Date: Wed, 20 Dec 2006 20:57:05 -0500
User-Agent: KMail/1.9.1
Cc: Dan Williams <dcbw@redhat.com>, Jiri Benc <jbenc@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20061219185223.GA13256@srcf.ucam.org> <1166638371.2798.26.camel@localhost.localdomain> <20061221011526.GB32625@srcf.ucam.org>
In-Reply-To: <20061221011526.GB32625@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12965929.GjvsYcSQMa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612202057.09545.flamingice@sourmilk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12965929.GjvsYcSQMa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 20 December 2006 20:15, Matthew Garrett wrote:
> Because it works on the common hardware? If there's documentation about
> what userspace can legitimately expect, then I'm happy to defer to that.
> But in the absence of any indication as to what functionality users can
> depend on, deciding that existing functionality is a bug is, well,
> impolite.
>
No, it's absolutely a bug. It just so happens that some drivers incorrectly=
=20
allowed it.

=2DMichael Wu

--nextPart12965929.GjvsYcSQMa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFien1T3Oqt9AH4aERAidHAKCekXO7SiOHvqXnZRyoRABKTiXnkgCfeI2g
rgqrbYoK7HmyZ7V0cmoEPT0=
=swlF
-----END PGP SIGNATURE-----

--nextPart12965929.GjvsYcSQMa--

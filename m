Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUI2QoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUI2QoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUI2QoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:44:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268674AbUI2QoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:44:04 -0400
Subject: RE: patch so cciss stats are collected in /proc/stat
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-frRLFQu3OXujFAHoidhw"
Organization: Red Hat UK
Message-Id: <1096476186.2786.45.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 18:43:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-frRLFQu3OXujFAHoidhw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-29 at 18:29, Miller, Mike (OS Dev) wrote:

> > This patch has been reject about half a million times, why are people
> > submitting it again and again?
>=20
> As I said in my mail, it's a customer driven issue. As long as customers =
rely on /proc/stat we'll keep trying. You can't tell a customer how he/she =
should be doing things on their systems.

I doubt you have many customers using 2.4.28.... I suspect that by now
the majority of people is either using an (ancient) 2.4 vendor kernel or
a 2.6 kernel. The very low number of reports on lkml about 2.4 seems to
confirm that ...

--=-frRLFQu3OXujFAHoidhw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWuYaxULwo51rQBIRAtEEAKCWnF3bYNxFGYT3sILR72G59/h81wCfVnxs
aRL4duPegsg1w9/xvTu5fXE=
=/f2B
-----END PGP SIGNATURE-----

--=-frRLFQu3OXujFAHoidhw--


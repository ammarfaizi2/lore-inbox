Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTL1Vqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTL1Vqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:46:33 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:15240 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262098AbTL1Vqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:46:30 -0500
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20031228213535.GA21459@mail-infomine.ucr.edu>
References: <20031228180424.GA16622@mail-infomine.ucr.edu>
	 <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu>
	 <20031228213535.GA21459@mail-infomine.ucr.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F/ebGGYrkF/C3/PoPhKb"
Organization: Red Hat, Inc.
Message-Id: <1072647938.10298.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 28 Dec 2003 22:45:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F/ebGGYrkF/C3/PoPhKb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-28 at 22:35, Johannes Ruscheinski wrote:

> Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
> hardware raid capability of the Promise tx4000 and if we'd use software
> raid instead, what would be the CPU overhead?

be careful, almost all ata raid controllers out there are *software
raid* hidden in a binary only driver. Also generally the on-disk format
of these is quite unfortionate resulting in slower access than linux
software raid can do...

--=-F/ebGGYrkF/C3/PoPhKb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/708CxULwo51rQBIRArQgAJ0f1tjJnRZ+jTdL4PssAMSNTye/rACfcCS0
iwbWBUaJP9GgrWRRgzIjlak=
=Fy23
-----END PGP SIGNATURE-----

--=-F/ebGGYrkF/C3/PoPhKb--

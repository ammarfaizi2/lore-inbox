Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTKFRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTKFRB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:01:58 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:51075 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263762AbTKFRBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:01:55 -0500
Subject: Re: Highmem SCSI driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Mark Mokryn <markm@il.marvell.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@vger.kernel.org
In-Reply-To: <3FAA712F.2030409@il.marvell.com>
References: <3FAA712F.2030409@il.marvell.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CCwyfmWjAPPFahdBEn8q"
Organization: Red Hat, Inc.
Message-Id: <1068138107.5234.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 Nov 2003 18:01:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CCwyfmWjAPPFahdBEn8q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 17:05, Mark Mokryn wrote:
> We are trying to test 64-bit PCI DMA for a SCSI driver on a Xeon box,=20
> RH9 2.4.20-8 bigmem kernel, 6GB RAM.
> The machine shows 6GB in top, we set highmem_io in the driver, PCI DMA=20
> mask covers 64-bit range, etc.

can you give an URL to the driver so that we can see why it breaks ?


--=-CCwyfmWjAPPFahdBEn8q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/qn57xULwo51rQBIRAl73AJ4iREs+pKaE4FnosuvXo2lUnpdhCwCdG1Oy
j+INZ5WOJB7OZhZqIkzBmGw=
=Jh1t
-----END PGP SIGNATURE-----

--=-CCwyfmWjAPPFahdBEn8q--

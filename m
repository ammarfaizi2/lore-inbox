Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUHXWdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUHXWdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269009AbUHXWdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:33:33 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:15596 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S269008AbUHXWd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:33:27 -0400
Subject: Re: 2.6.8.1-mm2 (nvidia breakage) [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Roland Dreier <roland@topspin.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
In-Reply-To: <20040824220307.GO1078@hygelac>
References: <20040819092654.27bb9adf.akpm@osdl.org>
	 <200408230930.18659.bjorn.helgaas@hp.com> <20040823190131.GC1303@hygelac>
	 <200408240926.42665.bjorn.helgaas@hp.com> <52vff8phf5.fsf@topspin.com>
	 <20040824220307.GO1078@hygelac>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CKR1VC2gGtZ7TnBWFgIu"
Message-Id: <1093386902.12957.15.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 00:35:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CKR1VC2gGtZ7TnBWFgIu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-25 at 00:03, Terence Ripperda wrote:
> On Tue, Aug 24, 2004 at 10:36:14AM -0700, roland@topspin.com wrote:
> > Terence, correct me if I'm wrong, but the change to add
> > pci_enable_device() goes in the part of the nvidia driver that has
> > source available.  So users can apply this patch themselves even
> > without another Nvidia release.
>=20
> correct.
>=20

Should just pass it along to minion.de ...


--=20
Martin Schlemmer

--=-CKR1VC2gGtZ7TnBWFgIu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBK8KWqburzKaJYLYRArfmAJ9D1M7opOh7AKPnM0Lwtr2GrrOxnQCeLqZP
k4ULEhyDT9pMjvVTnjnUFRY=
=32gt
-----END PGP SIGNATURE-----

--=-CKR1VC2gGtZ7TnBWFgIu--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264779AbUEYGxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbUEYGxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 02:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEYGxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 02:53:39 -0400
Received: from mx2.redhat.com ([66.187.237.31]:62618 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264779AbUEYGxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 02:53:38 -0400
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Greg KH <greg@kroah.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20040524210146.GA5532@kroah.com>
References: <20040524210146.GA5532@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BEcWa4vKHJLsYRKeUfv0"
Organization: Red Hat UK
Message-Id: <1085468008.2783.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 May 2004 08:53:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BEcWa4vKHJLsYRKeUfv0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-24 at 23:01, Greg KH wrote:
> Hi,
>=20
> Now that the ACPI portion of PCI Express support is in the 2.4 kernel
> tree, I can send you the remaining portion to actually enable this
> feature to work properly.  Here is the PCI Express support for i386 and
> x86_64 platforms backported from 2.6 to the 2.4 kernel.


how does this mesh with the "2.4 is now feature frozen"?
Especially since you don't NEED this patch to run on pci express
hardware, it's just that you can use a few performance tweaks.


--=-BEcWa4vKHJLsYRKeUfv0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsu1oxULwo51rQBIRAlNgAKCpk1Glc+t6Jpg2Ptqxl/uCqRysYACcD4UI
9kQQT2o/kUmkSU3n+tDivE4=
=HW0N
-----END PGP SIGNATURE-----

--=-BEcWa4vKHJLsYRKeUfv0--


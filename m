Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUFNEvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUFNEvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFNEvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:51:10 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:55052 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S261867AbUFNEvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:51:06 -0400
Date: Sun, 13 Jun 2004 23:51:04 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Ryan Underwood <nemesis-lists@icequake.net>,
       Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040614045104.GE27622@dbz.icequake.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	Ryan Underwood <nemesis-lists@icequake.net>,
	Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet> <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk> <20040613220727.GB4771@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <20040613220727.GB4771@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 13, 2004 at 07:07:27PM -0300, Marcelo Tosatti wrote:
>=20
> Jesper,=20
>=20
> Two more things.
>=20
> It seems v2.6 also lacks support for this boards:
>=20
> grep PCI_DEVICE_ID_NETMOS_ *
> pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9735     0x9735
> pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9835     0x9835
> [marcelo@localhost linux]$
>=20
> Care to prepare a v2.6 version?

Seems like someone already did, but I guess it did not get applied for
some reasons:
http://seclists.org/lists/linux-kernel/2003/Dec/0654.html

--=20
Ryan Underwood, <nemesis@icequake.net>

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzS64IonHnh+67jkRAh14AKCQEi/VaFR+rCpugww8Y74PlkEY1QCgi0ch
NclPXBxAOE3bIECDm8YOY5w=
=+wXL
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTFMQxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTFMQxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:53:46 -0400
Received: from grendel.firewall.com ([66.28.56.41]:22248 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S265326AbTFMQxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:53:43 -0400
Date: Fri, 13 Jun 2003 19:07:21 +0200
From: Marek Habersack <grendel@caudium.net>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.70-mm8 and the 3com NIC driver
Message-ID: <20030613170721.GA1768@thanes.org>
Reply-To: grendel@caudium.net
References: <20030612214626.GA1770@thanes.org> <200306130927.06971.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <200306130927.06971.schlicht@uni-mannheim.de>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2003 at 09:27:02AM +0200, Thomas Schlichter scribbled:
[snip]
> 1. Disable ACPI (for example with the 'acpi=3Doff' boot option)
>   This was no major impact for me as ACPI never worked here well...
>=20
> 2. Revert the pci-init-ordering-fix from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.=
70-mm8/broken-out/pci-init-ordering-fix.patch
>   This may be only suboptimal, as this patch seems to fix some problems...
Thanks for the tips but, fortunately, with -mm9 they were no longer needed -
it works like a charm.

thanks again,

marek

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6gTJq3909GIf5uoRAq9XAJ4zfv1e8q7I4Zpe1X52oaxh18fEbgCgiBLO
CqRv9anTt3kKvfjB4OwjSgo=
=1UAV
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUFIQWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUFIQWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFIQWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:22:13 -0400
Received: from trantor.org.uk ([213.146.130.142]:30156 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263975AbUFIQWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:22:12 -0400
Subject: Re: PCI configuration failure
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Lars Knudsen <gandalf@revicon.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40C733A0.8080700@revicon.com>
References: <40C733A0.8080700@revicon.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uviyUeSexbsv0GTDHR1w"
Date: Wed, 09 Jun 2004 17:22:07 +0100
Message-Id: <1086798127.21922.249.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uviyUeSexbsv0GTDHR1w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-09 at 17:58 +0200, Lars Knudsen wrote:
> Any suggestions on how to fix this problem are highly appreciated.

Perhaps the 'resource' sysfs node could be made writable and allow
remapping of BARs and resource lens in kernel?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-uviyUeSexbsv0GTDHR1w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAxzkukbV2aYZGvn0RAvq7AJ49H0KMGPWq+yzbUpMtCmxt472IvwCcDndf
NJ+KaLYmHx30V2LjeRYfXco=
=UEFR
-----END PGP SIGNATURE-----

--=-uviyUeSexbsv0GTDHR1w--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUDKRZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUDKRZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 13:25:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262434AbUDKRZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 13:25:18 -0400
Subject: Re: List of oversized inlines
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040411170340.GB1287@gallifrey>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20040411163255.GB6248@waste.org>
	 <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20040411170340.GB1287@gallifrey>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zvi/kQYMMYVKUJfT4Sdn"
Organization: Red Hat UK
Message-Id: <1081704303.4680.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Apr 2004 19:25:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zvi/kQYMMYVKUJfT4Sdn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-04-11 at 19:03, Dr. David Alan Gilbert wrote:
> Be careful in making judgements about the inlining behaviour based
> on sizes on one architecture.  The size of these functions
> is likely to be radically different on different architectures, and
> the break off point of cache/RAM usage v branch cost is also likely
> to be entirely different.

this is why such a choice most likely should be up to gcc.....
and it's getting a lot better at that nowadays.


--=-zvi/kQYMMYVKUJfT4Sdn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAeX9vxULwo51rQBIRAvNZAKCHUNtyqviIBxpAGC0EDLrvk+7MRgCffYP3
CpZB86LjllJmnRlhUvOBhro=
=+VwG
-----END PGP SIGNATURE-----

--=-zvi/kQYMMYVKUJfT4Sdn--


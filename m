Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUHENEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUHENEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUHENEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:04:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267668AbUHENES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:04:18 -0400
Subject: Re: [PATCH] Automatically enable bigsmp on big HP machines
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040805143837.4a6dce7e.ak@suse.de>
References: <20040805143837.4a6dce7e.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MXMMmzwsWm5GjKYmi9JY"
Organization: Red Hat UK
Message-Id: <1091711039.2790.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 15:03:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MXMMmzwsWm5GjKYmi9JY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-05 at 14:38, Andi Kleen wrote:
> This enables apic=3Dbigsmp automatically on some big HP machines that nee=
d it.=20
> This makes them boot without kernel parameters on a generic arch kernel.

is it possible for this to use the new dmi infrastructure, eg not add it
to dmi_scan.c but to the place where it's used ?

--=-MXMMmzwsWm5GjKYmi9JY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEjA/xULwo51rQBIRAp3jAJwM4YkbNQIgyVpk1v7iQnZq+CkR4gCfWRYZ
xzVZJ65dQdP0xPhB55spJhQ=
=MAhL
-----END PGP SIGNATURE-----

--=-MXMMmzwsWm5GjKYmi9JY--


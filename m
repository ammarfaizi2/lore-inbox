Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264758AbUEET7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264758AbUEET7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEET7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:59:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264758AbUEET7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:59:13 -0400
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Steve Lord <lord@xfs.org>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1083786663.3844.10.camel@laptop.fenrus.com>
References: <20040505013135.7689e38d.akpm@osdl.org>
	 <200405051312.30626.dominik.karall@gmx.net>
	 <20040505043002.2f787285.akpm@osdl.org>  <40991A8D.5000008@xfs.org>
	 <1083786663.3844.10.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6Vbw+uE4KChG2ifay6H9"
Organization: Red Hat UK
Message-Id: <1083787143.3844.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 May 2004 21:59:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6Vbw+uE4KChG2ifay6H9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> Now I'll fully admit the 2Kb is somewhat of a stochast, you only hit it
> if you have iptable rules and 2 nic irq's arriving on the same cpu at an
> unfortionate moment, but that doesn't mean it's a safe situation.

s/safe/safer than 2.6/

--=-6Vbw+uE4KChG2ifay6H9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAmUeHxULwo51rQBIRAvftAKCVpwKY0mGJ+KSMyp6o2Ur644pQhgCcDrDq
OnfdWDYz0QRn/japZDL+QDE=
=j3cJ
-----END PGP SIGNATURE-----

--=-6Vbw+uE4KChG2ifay6H9--


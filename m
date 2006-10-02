Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWJBRAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWJBRAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWJBRAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:00:32 -0400
Received: from cweiske.de ([80.237.146.62]:970 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S965132AbWJBRA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:00:28 -0400
Message-ID: <452145D0.5000308@cweiske.de>
Date: Mon, 02 Oct 2006 19:01:04 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de>	<20060923134244.e7b73826.akpm@osdl.org>	<451677FE.2070409@cweiske.de>	<20060924095029.0262a2c8.akpm@osdl.org>	<4516C4B9.5010509@cweiske.de>	<451821C9.6020602@cweiske.de> <20060925142630.fb39a613.akpm@osdl.org>
In-Reply-To: <20060925142630.fb39a613.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig40873C798B504452CA1E07E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40873C798B504452CA1E07E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew,

> Is it?  I don't recall us having established that.  Does the machine ru=
n
> any earlier kernel without failing?
The lowest version I could go back was 2.6.12 which also panicked, so I
guess it happens everywhere.

I am now trying to get a small disk that is not accessed via the pci ide
card, perhaps that brings more info.

--=20
Regards/MfG,
Christian Weiske


--------------enig40873C798B504452CA1E07E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFIUXVFMhaCCTq+CMRAkzWAJ9ItzRZe8QSuotBlSi59sSPKSW7IQCfRWtG
DJ0rJ2sEZiu1cvU6bY0nqbo=
=sOKv
-----END PGP SIGNATURE-----

--------------enig40873C798B504452CA1E07E3--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWARTHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWARTHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWARTHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:07:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030349AbWARTHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:07:21 -0500
Message-ID: <43CE91EA.2060204@redhat.com>
Date: Wed, 18 Jan 2006 11:07:22 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pepoll_wait ...
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain> <43CE8B14.4020909@tls.msk.ru>
In-Reply-To: <43CE8B14.4020909@tls.msk.ru>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBB282D0F6560B7E440A289CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB282D0F6560B7E440A289CF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Tokarev wrote:
> How about epoll_pwait() instead?  It looks more appropriate, for
> my eyes anyway.  (Just a name, nothing more)

It's just a name but I have thought along the same lines. It's just more
pleasing.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigBB282D0F6560B7E440A289CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzpHv2ijCOnn/RHQRAkftAKCeWv/+if0J/2FEVwG4d81o0iZDWACeJR6q
mwo520Fv0cgivsSo4aCetHQ=
=PjML
-----END PGP SIGNATURE-----

--------------enigBB282D0F6560B7E440A289CF--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFMG0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFMG0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFMG0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:26:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261376AbVFMG0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:26:30 -0400
Message-ID: <42AD2640.5040601@redhat.com>
Date: Sun, 12 Jun 2005 23:22:56 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: jnf <jnf@innocence-lost.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain> <1118616499.9949.103.camel@localhost.localdomain> <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org> <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg> <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig766CCA4FDADAB9C26B3F6991"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig766CCA4FDADAB9C26B3F6991
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Anyway, that's three different approaches, all of which are portable an=
d=20
> thus preferable to pselect() which is not.

pselect is portable, just not to current and old Linux systems.  It's in
POSIX for a while and the other Unixes have the interface.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig766CCA4FDADAB9C26B3F6991
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCrSZA2ijCOnn/RHQRAkd0AKCrl6xuXBvng/Z1u/CMPUPvPkeqVACfblu0
WZhUTBTh16O662gCBW1sE84=
=k35N
-----END PGP SIGNATURE-----

--------------enig766CCA4FDADAB9C26B3F6991--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946151AbWBEAsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946151AbWBEAsB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 19:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWBEAsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 19:48:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751272AbWBEAsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 19:48:00 -0500
Message-ID: <43E54BAD.5060604@redhat.com>
Date: Sat, 04 Feb 2006 16:49:49 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: One more unlock missing in error case
References: <43E4E318.1030304@redhat.com> <20060204160830.1a9810a2.akpm@osdl.org>
In-Reply-To: <20060204160830.1a9810a2.akpm@osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig925A45BC03E98150376D5D3C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig925A45BC03E98150376D5D3C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
> hmm.  How's about we undo that goto tangle while we're there?

Fine with me.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig925A45BC03E98150376D5D3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD5Uuy2ijCOnn/RHQRAm2wAJ9XBV5CRnnP6xQNo/tjZubUVkhiawCcCDWv
GB5S7pu/m/83SvFaph6G59E=
=cjab
-----END PGP SIGNATURE-----

--------------enig925A45BC03E98150376D5D3C--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWKHBXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWKHBXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbWKHBXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:23:32 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:56266 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1752129AbWKHBXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:23:31 -0500
Message-ID: <455130DB.3020307@trn.iki.fi>
Date: Wed, 08 Nov 2006 03:20:27 +0200
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic+bpsk@trn.iki.fi>
User-Agent: Thunderbird 1.5.0.4 (X11/20060605)
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mapping between ata9 and /dev/sd[a-z]
References: <454FD142.5060103@trn.iki.fi> <jefycwukzg.fsf@sykes.suse.de>
In-Reply-To: <jefycwukzg.fsf@sykes.suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A9CCD3E31386F58F94ECE05"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A9CCD3E31386F58F94ECE05
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> I am getting errors from ata9 (and ata10), but how can I find which HD=
D
>> it is? The kernel log never mentions ataN and its associated device na=
me
>> together.
>=20
> Try looking in /sys for clues.

Couldn't find any references to ataN from there.

- Tronic -



--------------enig3A9CCD3E31386F58F94ECE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUTDfOBbAI1NE8/ERAgqPAKCtJbMKWeoJRDA9xBE4JpeOvpRoBQCfT8Km
4t9kwH9cPskS6wsHMjeWTNk=
=tN6w
-----END PGP SIGNATURE-----

--------------enig3A9CCD3E31386F58F94ECE05--

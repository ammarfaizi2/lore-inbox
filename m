Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbUKRL2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUKRL2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKRL2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:28:30 -0500
Received: from 66.80-203-204.nextgentel.com ([80.203.204.66]:59013 "EHLO
	66.80-203-204.nextgentel.com") by vger.kernel.org with ESMTP
	id S261767AbUKRL2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:28:25 -0500
Message-ID: <419C8756.3080709@nidelven-it.no>
Date: Thu, 18 Nov 2004 12:28:22 +0100
From: "Morten W. Petersen" <morten@nidelven-it.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fixing page allocation failure
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDD6FE60C9047DA2137797A85"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD6FE60C9047DA2137797A85
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have a server that a couple of times each day squirts out messages 
about page allocation failures (python: page allocation failure. 
order:3, mode:0x20).  What's the reason for this, and could it affect 
the stability of the box?

The server that squirts these messages just crashed, for no apparent 
reason, so that's why I'm wondering.  It's a UML box.  Also, I'm 
wondering, are there any howto's for tweaking /proc settings so that the 
machine becomes more stable?  Are there any settings for increasing the 
verbosity of the kernel log so that the reason for a server crashing is 
easier to find?

Thanks in advance, and please CC me any replies :)

Regards,

Morten

--------------enigDD6FE60C9047DA2137797A85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnIdWbYZVKBu9STYRAlJfAKDWy11LH3C1lNxEBy2dO6KdKgOMxACfeq3D
eooHbKRRS05Bh3xQsizxkC4=
=dG4O
-----END PGP SIGNATURE-----

--------------enigDD6FE60C9047DA2137797A85--

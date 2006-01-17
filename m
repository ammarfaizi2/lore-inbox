Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWAQT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAQT1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAQT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:27:11 -0500
Received: from host-87-74-62-169.bulldogdsl.com ([87.74.62.169]:47429 "EHLO
	host-87-74-62-169.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751265AbWAQT1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:27:10 -0500
Message-ID: <43CD4504.8020705@unsolicited.net>
Date: Tue, 17 Jan 2006 19:27:00 +0000
From: David R <david@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD838971DC5B3B9A4E3F3AEA9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD838971DC5B3B9A4E3F3AEA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Ok, it's two weeks since 2.6.15, and the merge window is closed.

Everything seems fine with rc1 on my VIA Based Athlon 64 (64 bit kernel, SuSE
10 base) apart from my USB2 scanner. It's detected just fine (as normal), but
the (32bit) copy of VueScan that I use crawls along during preview like a
constipated tortoise. This is markedly similar to when 2.6.15 is under heavy
CPU load... high speed USB transfers slow to a crawl then too but everything
is fine at other times.

dmesg etc looks ok. I'd appreciate it if anyone has any thoughts?

Cheers
David


--------------enigD838971DC5B3B9A4E3F3AEA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzUUKDYHcaCYtZo4RAp/AAJ9kohlzwpB7/E2n2es0uHvVSKU5WQCg0j37
d7H2iASEhybOkoAQt8JpOf4=
=0fJb
-----END PGP SIGNATURE-----

--------------enigD838971DC5B3B9A4E3F3AEA9--

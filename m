Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVAYN3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVAYN3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVAYN3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:29:43 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:37332 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261937AbVAYN3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:29:41 -0500
Message-ID: <41F649CB.5000906@kolivas.org>
Date: Wed, 26 Jan 2005 00:29:47 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc2-mm1: freeing b_committed_data
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig45F290B0A7B7B56DA2B6890C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45F290B0A7B7B56DA2B6890C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Getting a few of these:
__journal_remove_journal_head: freeing b_committed_data

in my dmesg with this kernel. It's ext3 on a P-ATA drive.

Bad? Dangerous? harmless debugging stuff?

Con

--------------enig45F290B0A7B7B56DA2B6890C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9knLZUg7+tp6mRURAiIwAJ941/d2XqPBEalj8MdYwgIdwAeT/ACeL77M
b8mBpvkBzxxbuIhroFKC44E=
=UXVe
-----END PGP SIGNATURE-----

--------------enig45F290B0A7B7B56DA2B6890C--

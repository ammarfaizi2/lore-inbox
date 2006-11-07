Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753867AbWKGAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbWKGAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbWKGAS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:18:58 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:61068 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1753867AbWKGAS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:18:57 -0500
Message-ID: <454FD142.5060103@trn.iki.fi>
Date: Tue, 07 Nov 2006 02:20:18 +0200
From: Lasse Karkkainen <tronic@trn.iki.fi>
User-Agent: Thunderbird 1.5.0.5 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mapping between ata9 and /dev/sd[a-z]
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I am getting errors from ata9 (and ata10), but how can I find which HDD
it is? The kernel log never mentions ataN and its associated device name
together.

There are too many controllers and too many disks of the same size to
use that for guessing.

- - Tronic -
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFT9FCOBbAI1NE8/ERAh4TAKC7RnoX0SswHUUtsrPORAqicj/RWwCgho6D
iObmY5ugImIFqf0jqGU9JWc=
=h2VH
-----END PGP SIGNATURE-----

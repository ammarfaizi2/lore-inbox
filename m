Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVGPPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGPPSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVGPPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:18:13 -0400
Received: from 213-133-123-7.clients.your-server.de ([213.133.123.7]:54419
	"EHLO necroshine.de") by vger.kernel.org with ESMTP id S261651AbVGPPSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:18:10 -0400
Message-ID: <42D92530.1020300@necroshine.de>
Date: Sat, 16 Jul 2005 17:18:08 +0200
From: Frederic Gaus <mailinglists@necroshine.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCMCIA_SOCKET unable to apply filter after Ram Upgrade
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi folks!

I've recently done a RAM upgrade on my IBM Thinkpad R40 (2722).

1. Ram-Chip: pc2100 cl 2.5 512 MB
2. Ram-Chip: pc2700 cl 2.5 1024 MB

When booting with only one Chip inside, everything works perfecly.
(Never mind in which slot). But when using both, I get this error
message every few seconds:

	kernel: cs: pcmcia_socket0: unable to apply power.

Changing the slots does't fix the problem. High Memory Support is enabled.

Who can help? Or do you need more information?

Thanks

Freddy

- --
Frederic Gaus                                 pgp-key: 93E6903C
fingerprint: 0C55 4517 CC1E 5F7F 9059  3535 AB54 D8E8 93E6 903C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC2SUwq1TY6JPmkDwRAuemAKDR3fAysip0ZyvSCeiV/6nxDHzcwwCgxC03
S1IyObIqnjyN2ZzMo20PSBY=
=D1lj
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267395AbUGNO6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267395AbUGNO6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUGNO6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:58:00 -0400
Received: from mout1.freenet.de ([194.97.50.132]:30876 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S267406AbUGNOyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:54:47 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [Q] don't allow tmpfs to page out
Date: Wed, 14 Jul 2004 16:54:29 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407141654.31817.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Is it possible to disable the tmpfs feature to page out
memory to swap?
I didn't find any mount option or something like that
for it in the documentation.

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9UklFGK1OIvVOP4RAvlyAKC0Aoug0HRSa8zRQuFAH8ufFY1C+wCg0ycG
uMXEYVntwUiiueZloUnizPo=
=t1IM
-----END PGP SIGNATURE-----

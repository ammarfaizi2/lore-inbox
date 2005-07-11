Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGKJ3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGKJ3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVGKJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:29:04 -0400
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:1756
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S261503AbVGKJ2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:28:14 -0400
Message-ID: <42D23B24.9040407@winischhofer.net>
Date: Mon, 11 Jul 2005 11:25:56 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 62/82] remove linux/version.h from drivers/video/sis
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Olaf Hering wrote:
> changing CONFIG_LOCALVERSION rebuilds too much, for no appearent
> reason.

[...]

> drivers/video/sis/init.h      |    5
> drivers/video/sis/init301.h   |    5
> drivers/video/sis/sis.h       |   46 --
> drivers/video/sis/sis_accel.c |  171 ---------
> drivers/video/sis/sis_accel.h |   13
> drivers/video/sis/sis_main.c  |  784 ------------------------------
> drivers/video/sis/sis_main.h  |   55 --
> drivers/video/sis/vgatypes.h  |    3
> 8 files changed, 1 insertion(+), 1081 deletions(-)


Please do NOT apply this.

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0jskzydIRAktyUcRAo0gAKCwKAvQwa3YQz817JEYctiOsgUFrQCgrAFe
cg3hfbK320KjqojE7PjkmnM=
=L7jH
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSILJJm>; Thu, 12 Sep 2002 05:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSILJJm>; Thu, 12 Sep 2002 05:09:42 -0400
Received: from AGrenoble-101-1-3-4.abo.wanadoo.fr ([193.253.251.4]:19849 "EHLO
	elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S314514AbSILJJl> convert rfc822-to-8bit; Thu, 12 Sep 2002 05:09:41 -0400
Message-ID: <3D805DC6.8000804@wanadoo.fr>
Date: Thu, 12 Sep 2002 11:26:30 +0200
From: FD Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 don't find my root (aic7xxx or ???)
References: <20020912090755.GA5890@ulima.unil.ch>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Gregoire Favre wrote:
| Hello,
|
| Linux version 2.5.34 (greg@localhost.localdomain) (gcc version 3.2
(Mandrake Linux 9.0 3.2-1mdk)) #2 Wed Sep 11 21:03:41 CEST 2002

(...) snip

| NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
| VFS: Cannot open root device "812" or 08:12
| Please append a correct "root=" boot option
| Kernel panic: VFS: Unable to mount root fs on 08:12
|  <6>SysRq : Resetting
|
| Any idea what I should do?
| The same lilo config with 2.4.x-ac runs just fine ;-)
|
| 	Grégoire

Hello,

Maybe you didn't compile the right filesystem for your / in your
kernel. Check supported Filesystems in your kernel config.

Cheers,

- --

F. CAMI
- ----------------------------------------------------------
~ "To disable the Internet to save EMI and Disney is the
moral equivalent of burning down the library of Alexandria
to ensure the livelihood of monastic scribes."
~              - John Ippolito (Guggenheim)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9gF3GuBGY13rZQM8RAiCWAJ99qsZVwk0YlInrvrjh6Ddickb0TgCdFwE4
1XeAN846R8cWRQ6FinqlQZE=
=8Fk8
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTBBGul>; Sun, 2 Feb 2003 01:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbTBBGul>; Sun, 2 Feb 2003 01:50:41 -0500
Received: from ns3310.ovh.net ([213.186.37.170]:29701 "EHLO ns3310.ovh.net")
	by vger.kernel.org with ESMTP id <S265114AbTBBGuk>;
	Sun, 2 Feb 2003 01:50:40 -0500
Date: Sun, 2 Feb 2003 00:58:19 -0500
From: leonard <leonard@internetdown.org>
To: linux-kernel@vger.kernel.org
Subject: MenuConfig 2.4.20 does n0t show all drivers (ACPI, SONYPI, UDF_RW) + MAINTAINERS
Message-Id: <20030202005819.605e17f2.leonard@internetdown.org>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; Gurney Halleck: The slow blade penetrates the shield)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello great Gurus ;)

Eventough the drivers are provided in the source tree,
some options are missing (?!) in the 'make menuconfig'
of the linux 2.4.20 kernel.

Thoses I found missing are the drivers for : ACPI, SONYPI, UDF_RW.

I added them -by hand- to .config and it went fine
(but only if I didn't relaunch make menuconfig after...)

Just letting you know :)

Besides, the MAINTAINERS file included in the kernel source is a
little out of date regarding the "CONFIGURE, MENUCONFIG, XCONFIG"
section : mec@shout.net is not the right person to write to anymore.

Sat, 1 Feb 2003 11:50:19 -0600, Michael Elizabeth Chastain <mec@shout.net>:
> The 'kbuild-devel' list mentioned in MAINTAINERS has been inactive
> for about six months, too.

Sincerely,
Guillaume

- -- 
"et ta lumiere jaillira comme l'aurore, et bien vite tes forces
viendront - tu appeleras, le seigneur repondra - tu crieras, il
te dira : me voici!"

Clef 0x6D525996 |> www.keyserver.net pgp.mit.edu pki.surfnet.nl
Fingerprint = 3B64 5F7C B27B A047 AF4F E5FD A2A3 B0D3 6D52 5996
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+PLN7oqOw021SWZYRAjQ9AKCSWvR2yVCUm2nIr4H/tQtfhZruQgCfZv0y
SLGIhYQdWzQ2ON1bO2ArxhI=
=dCzZ
-----END PGP SIGNATURE-----

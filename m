Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKRO0x>; Mon, 18 Nov 2002 09:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKRO0x>; Mon, 18 Nov 2002 09:26:53 -0500
Received: from maile.telia.com ([194.22.190.16]:21739 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S261456AbSKRO0w>;
	Mon, 18 Nov 2002 09:26:52 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Mon, 18 Nov 2002 15:33:38 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
To: dillowd@y12.doe.gov
Cc: linux-kernel@vger.kernel.org
Subject: Status of 3Com 3CR990 driver
Message-Id: <20021118153338.3e93f0b8.smiler@lanil.mine.nu>
Organization: LANIL
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="7qShTUIbs2H4=.m+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--7qShTUIbs2H4=.m+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I couple of weeks ago I read a post from David Dillow about drivers for the
3CR990 NICs
(http://www.3com.com/products/en_US/detail.jsp?tab=features&pathtype=purchase&s
ku=3CR990-TX-95).
Now I wonder how work is progressing as I've got a hand of one of these cards
for free :)

The current drivers from 3com (download at
http://support.3com.com/infodeli/tools/nic/linux/3c990-24-1.0.0a.tar.gz) compile
but doesn't load, it only spits out:
Nov 18 14:51:58 sm-wks1 3Com  3c990.c  v1.0.0b  10/2000
Nov 18 14:52:03 sm-wks1 3c990: There appear to be inadequate resources at this
time and on this machine for this driver.  Killing further initialization.

If there will be a 2.4 backport of the driver David is writing, I'll be happy to
beta-test it for him :)

--
Christan Axelsson
smiler@lanil.mine.nu

--7qShTUIbs2H4=.m+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92PpOyqbmAWw8VdkRAqL4AKDBkRxfGV9O0jG2IhBUy8lUV62IlACgoFk0
2h2lsqxQBRlF7KNW30dgBQg=
=1X+B
-----END PGP SIGNATURE-----

--7qShTUIbs2H4=.m+--

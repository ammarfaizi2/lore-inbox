Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbSJBJJA>; Wed, 2 Oct 2002 05:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbSJBJI7>; Wed, 2 Oct 2002 05:08:59 -0400
Received: from snickers.hotpop.com ([204.57.55.49]:456 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP
	id <S263009AbSJBJI6>; Wed, 2 Oct 2002 05:08:58 -0400
Date: Wed, 2 Oct 2002 19:14:08 +1000
From: Colin Stubbs <cstubbs@gamebox.net>
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: error useing menuconfig
Message-Id: <20021002191408.593a6773.cstubbs@gamebox.net>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, while configuring 2.5.40, I attempted to enter the "Advanced Linux Sound Architecture" section, sub-section of Sound, it died with the following output.

=======================================================================
Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
[root@anduril][/usr/src/linux]$ 
=====================================================================


Regards

Colin Stubbs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mrjgAXdwal420Q0RAlKvAKCFsfE/zft9PR08R04KXDDMsCDCCgCgr5bx
9Jhf9+KGPotgO2s5IkbzfjY=
=IMLk
-----END PGP SIGNATURE-----


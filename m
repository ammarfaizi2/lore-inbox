Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTIFTBa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbTIFTBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:01:30 -0400
Received: from c2mailgwalt.mailcentro.com ([207.183.238.112]:28091 "EHLO
	c2mailgwalt.mailcentro.com") by vger.kernel.org with ESMTP
	id S261278AbTIFTB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:01:28 -0400
X-Version: Mailcentro(english)
X-SenderIP: 80.58.9.42
X-SenderID: 7831070
From: "Jose Luis Alarcon Sanchez" <jlalarcon@chevy.zzn.com>
Message-Id: <A340D5F1860783E4BBC9E429C5A7DAFD@jlalarcon.chevy.zzn.com>
Date: Sat, 6 Sep 2003 21:01:24 +0200
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: armin@xos.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 latencey problems + howto compilation
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Begin Original Message ----

From: Armin Obersteiner <armin@xos.net>
Sent: Sat, 6 Sep 2003 19:17:44 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6-test4 latencey problems + howto compilation

hi!

Congratulations for the 2.6 kernel, it seems more mature than 2.4 test
kernels!
 
My 2.6 experience (linux-2.6.0-test4) is basically *very* good, but
some remarks:

1) Documents/Changes should be updated to:

    module-init-tools      0.9.13                  # depmod -V

  Earlier module-init-tools do not work. at least nor for me.

.......

---- End Original Message ----


  Hi Armin.

  I don't know why the previous module-init-tools don't work
for your system. I am using the 2.6.0-test4 kernel (with the
Nick Piggin ideas about schedule patched) and i can manage
modules perfectly. This is my depmod -V output:

module-init-tools 0.9.10

  Maybe you can have another thing broken?.

  Regards.

  Jose.


http://linuxespana.scripterz.org

FreeBSD RELEASE 4.8.
Mandrake Linux 9.1 Kernel 2.6.0-test4 XFS.
Registered BSD User 51101.
Registered Linux User #213309.
Memories..... You are talking about memories. 
Rick Deckard. Blade Runner.


Get your Free E-mail at http://chevy.zzn.com
__________________
http://www.zzn.com

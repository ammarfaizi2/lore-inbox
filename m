Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbTGIJHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbTGIJHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:07:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265818AbTGIJGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:06:52 -0400
Message-ID: <33125.4.4.25.4.1057742478.squirrel@www.osdl.org>
Date: Wed, 9 Jul 2003 02:21:18 -0700 (PDT)
Subject: [announce] patch-2.5.74-kj1
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <kernel-janitor-discuss@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working off the (vacation) backlog, but still plenty to go.

Please let me know if you use/test this.


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.5.74/patch-2.5.74-kj1.bz2

changes since patch-2.5.73-kj1:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/    unused_var_drivers_serial_8250_cs.patch
        Daniele Bellucci <bellucda@tiscali.it>

add/    unchkd_return_copy_from_user_net_core_pktgen.c
        Steffen Klassert <klassert@mathematik.tu-chemnitz.de>

add/    pci_name_diff.txt
        "Warren A. Layton" <zeevon@debian.org>

add/    typo-usb-serial-kconfig.patch
        Francois Romieu <romieu@fr.zoreil.com>

add/    uninit_static_misc.patch
        uninit_static_sound.patch
        uninit_static_fs.patch
        uninit_static_net.patch
        Leann Ogasawara

changes since patch-2.5.70-bk13-kj:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop/   je_cpqarray_fix_stack_usage.patch
        Jorn Engel and Randy Dunlap
        merged by akpm on 2003-06-10 (in 2.5.71)

keep/   je_wanrouter_fix_stack_usage.patch
        Jorn Engel and Randy Dunlap

add/    unchecked_copytouser.patch
        in fs/proc_misc.c: Daniele Belluci

add/    busmouse_retcode_memleak.patch
        Flavio B. Leitner

###

~Randy




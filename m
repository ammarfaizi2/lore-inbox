Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDFLPf (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDFLPf (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 07:15:35 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:3064 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262931AbTDFLPe (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 07:15:34 -0400
Message-ID: <3E900F09.18EF30CE@eyal.emu.id.au>
Date: Sun, 06 Apr 2003 21:27:05 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre7 ipmi unresolved
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all modules. With two small patches to get HPT372N and ac97
to compile.

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre7/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre7/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre7/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

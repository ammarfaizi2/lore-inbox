Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271083AbTGPTkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271089AbTGPTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:40:14 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:27819 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S271083AbTGPTkL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:40:11 -0400
Date: Wed, 16 Jul 2003 21:55:02 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 260-t1(ac1) don't boot on my Mandrake Cooker (2573 does)
Message-ID: <20030716195502.GD7158@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't boot with either 2.6.0-test1, neither with 2.6.0-test1-ac1, it
ends like this:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sdb2) for (sdb2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
INIT: version 2.85 booting
INIT: Kernel panic: Attempted to kill init!
cannot execute "/etc/rc.d/rc.sysinit"

I don't know what the problem is, as the same configuration works
juste perfectly with 2.5.73???

Please CC to me as I am not on this ml ;-)

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

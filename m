Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSGTPpz>; Sat, 20 Jul 2002 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSGTPpz>; Sat, 20 Jul 2002 11:45:55 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:11808 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317427AbSGTPpy>; Sat, 20 Jul 2002 11:45:54 -0400
Date: Sat, 20 Jul 2002 17:50:16 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.26] klogd problems?
Message-ID: <20020720155016.GA213@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.5.26 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After booting 2.5.26 I can see the following messages in my logs:

Jul 14 21:20:43 chiara syslogd 1.4.1: restart.
Jul 14 21:20:44 chiara kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 14 21:20:44 chiara kernel: Inspecting /boot/System.map-2.5.26
Jul 14 21:20:44 chiara kernel: Loaded 15251 symbols from /boot/System.map-2.5.26
Jul 14 21:20:44 chiara kernel: Symbols match kernelversion 2.5.26
Jul 14 21:20:44 chiara kernel: Error seeking in /dev/kmem
Jul 14 21:20:44 chiara kernel: Symbol #serial, value d8822000
Jul 14 21:20:44 chiara kernel: Error adding kernel module table entry.

No problems running 2.4. 
So what can I do? Running klogd with -x can't be the solution, I think....

-- 
# Heinz Diehl, 68259 Mannheim, Germany

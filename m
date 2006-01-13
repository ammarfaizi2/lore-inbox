Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161502AbWAMJQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161502AbWAMJQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161505AbWAMJQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:16:49 -0500
Received: from i5-7.dnslinks.net ([66.98.167.159]:17125 "HELO ip01-web5.net")
	by vger.kernel.org with SMTP id S1161502AbWAMJQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:16:49 -0500
Message-ID: <62439.61.247.248.51.1137144158.squirrel@66.98.166.28>
Date: Fri, 13 Jan 2006 09:22:38 -0000 (UTC)
Subject: REG:problem i am facing
From: balamurugan@sahasrasolutions.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

i am compiling kernel-2.4.32 with i386 processor with wirless lan and all
other facilites, it will compaile in make ,make dep, make menuconfig but i
going to intall with make install, the initrd is missing the following
error is displayed , please help on this issue.

warning: kernel is too big for standalone boot from floppy
sh -x ./install.sh 2.4.32 bzImage /bala/linux-2.4.32/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.32 bzImage /bala/linux-2.4.32/System.map ''
depmod: Can't open /lib/modules/2.4.32/modules.dep for writing
/lib/modules/2.4.32 is not a directory.
mkinitrd failed
make[1]: *** [install] Error 1
make[1]: Leaving directory `/bala/linux-2.4.32/arch/i386/boot'
make: *** [install] Error 2

the issue is very urgent , u please clear the doute asap .

thanks & regards
balamurugan.j


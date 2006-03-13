Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWCMUFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWCMUFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWCMUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:05:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:526 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751808AbWCMUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:05:46 -0500
Date: Mon, 13 Mar 2006 21:05:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com,
       dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com,
       Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>,
       Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: 2.6.16-rc6: known regressions
Message-ID: <20060313200544.GG13973@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : XFS oopses on my box sometimes
References : http://bugzilla.kernel.org/show_bug.cgi?id=6180
Submitter  : Avuton Olrich <avuton@gmail.com>
Status     : unknown


Subject    : 2.6.16-rc5 acpi slab corruption
References : http://lkml.org/lkml/2006/3/1/223
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : edac slab corruption
References : http://lkml.org/lkml/2006/3/5/14
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : yet more slab corruption
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184310
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : Slab corruption in usbserial when disconnecting device
References : http://lkml.org/lkml/2006/3/8/58
Submitter  : pete.chapman@exgate.tek.com
Status     : unknown


Subject    : 2.6.16-rc5-git14 crash in spin_bug on ppc64
References : http://lkml.org/lkml/2006/3/10/190
Submitter  : Olaf Hering <olh@suse.de>
Status     : unknown


Subject    : Stradis driver udev brekage
References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
             https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
             http://lkml.org/lkml/2006/2/18/204
Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
             Dave Jones <davej@redhat.com>
Handled-By : Jiri Slaby <jirislaby@gmail.com>
Status     : unknown


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


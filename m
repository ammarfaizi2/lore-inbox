Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272481AbTGZNEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272482AbTGZNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 09:04:46 -0400
Received: from web14203.mail.yahoo.com ([216.136.172.145]:1630 "HELO
	web14203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272481AbTGZNEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 09:04:45 -0400
Message-ID: <20030726131956.92831.qmail@web14203.mail.yahoo.com>
Date: Sat, 26 Jul 2003 06:19:56 -0700 (PDT)
From: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
Subject: Loading of modules fails while using  kernel 2.6.0-test1
To: linux-kernel@vger.kernel.org
Cc: manjunathan_py@yahoo.com
In-Reply-To: <Pine.LNX.4.53.0307260903550.31047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,
  Thanks for all, for assisting me in solving the
kernel booting problem.

 Now I am encountering another problem, after
successful compilation/installation/booting of kernel
2.6.0-test1 , the modules are not loading at all ,
even after installing the latest version of
"module-init-tools-0.9.13-pre" .

Below given the error message that is display during
booting time, when kernel checks for the hardware !

"XT3 FS on hda9, internal journal
Adding 538136k swap on /dev/hda10.  Priority:-1
extents:1
kudzu: numerical sysctl 1 23 is obsolete.
warning: process `update' used the obsolete bdflush
system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush
system call
Fix your initscripts?
kudzu: numerical sysctl 1 23 is obsolete.
module_upgrade: numerical sysctl 1 23 is obsolete.
module_upgrade: numerical sysctl 1 49 is obsolete.
module_upgrade: numerical sysctl 1 49 is obsolete.
kudzu: numerical sysctl 1 23 is obsolete.
updfstab: numerical sysctl 1 23 is obsolete.
updfstab: numerical sysctl 1 49 is obsolete.
updfstab: numerical sysctl 1 49 is obsolete.
kudzu: numerical sysctl 1 23 is obsolete."

Because of this, my sound card, D-link FM radio and
other periperal don't work.

Further when I execut the new lsmod command. Module
list is displayed empty.

I appreciate any asistance on this !

Thanks,
Manjunathan PY




__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com

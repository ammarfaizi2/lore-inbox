Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbTDJEJf (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 00:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTDJEJf (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 00:09:35 -0400
Received: from mail335.mail.bellsouth.net ([205.152.58.213]:20361 "EHLO
	imf33bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S263947AbTDJEJf (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 00:09:35 -0400
Date: Thu, 10 Apr 2003 00:21:47 -0400
From: cj_chitwood@bellsouth.net
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
Subject: Possible problem report, MDK 9.1 kernel config script
Message-Id: <20030410002147.62fa9449.cj_chitwood@bellsouth.net>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.

I was going through the menus for kernel configuration, and received an error.  The error was received when I tried to enter "Advanced Linux Sound Architecture" submenu from the sound support menu.  I was dropped to my terminal, and the following output was on my screen:

################ BEGIN QUOTE ################

Menuconfig has encountered a possible error in one of the kernel's configuration files and is unable to continue.  Here is the error report:

 Q> scripts/Menuconfig: line 832: MCmenu71: command not found

Please report this to the maintainer <mex@shout.net>.  You may also send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
[root@ip-two linux]# _

################# END QUOTE ################

I am running Mandrake 9.1, a gift sent to me from a friend via Cheapbytes.com.  The release version is 2.4.21-0.13mdk.  The machine is an i686 (Dell Inspiron 2500, Pentium-III).  If you need any further information, I'll gladly provide it if I can.  I have not tried any other configuration methods, such as those provided via the GUI or "make xconfig", and I would, if not for the late hour.

I hope this information helps, and have a good evening.

CJ Chitwood
This is my private e-mail address, please treat it as such;  thanks.

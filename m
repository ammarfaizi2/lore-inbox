Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263221AbSJCJmy>; Thu, 3 Oct 2002 05:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263222AbSJCJmy>; Thu, 3 Oct 2002 05:42:54 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:20433 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S263221AbSJCJmx>; Thu, 3 Oct 2002 05:42:53 -0400
Date: Thu, 3 Oct 2002 11:48:23 +0200
From: Frank Audun =?iso-8859-1?Q?Kvamtr=F8?= <kvamtro@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: menuconfig hangs (2.5.40)
Message-ID: <20021003094823.GB21895@stud.ntnu.no>
Reply-To: Frank Audun =?iso-8859-1?Q?Kvamtr=F8?= <kvamtro@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to configure kernel 2.5.40 and have tried so with the
standard kernel from www.kernel.org and with the -bk1 patch. Both my
tries to configure the kernel has hanged after trying to enter the
/sound/alsa menu, and exited with the given reason:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
bash-2.05a# 

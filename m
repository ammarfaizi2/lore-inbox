Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbSLPS36>; Mon, 16 Dec 2002 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbSLPS35>; Mon, 16 Dec 2002 13:29:57 -0500
Received: from [207.198.50.206] ([207.198.50.206]:4457 "HELO
	linus.in.park-net.com") by vger.kernel.org with SMTP
	id <S267026AbSLPS3x> convert rfc822-to-8bit; Mon, 16 Dec 2002 13:29:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Michael Aldrich <maldrich@reserveamerica.com>
To: mec@shout.net
Subject: RedHat Kernel Error
Date: Mon, 16 Dec 2002 13:44:15 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212161344.15507.maldrich@reserveamerica.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was trying to recompile my 2.4.18-3smp RedHat kernel and received the 
following error after running 'make menuconfig' and selecting 'Networking 
options:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu17: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
[root@localhost linux-2.4]#

Thanks
Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEKOwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEKOwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:52:17 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.251]:43729 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S261589AbTEKOwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:52:15 -0400
From: Christian Muenscher <cmuenscher@crion.de>
Reply-To: crion@gmx.de
To: mec@shout.net
Subject: Menuconfig crash @ line 832
Date: Sun, 11 May 2003 17:05:51 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305111705.51550.cmuenscher@crion.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My "make menuconfig" - Session on Kernel Mandrake 2.4.21-0.1mdkcustom failed 
when selecting "Advanced Linux Sound Architecture" within the "Sound" - Menu.

The exact error message:

------------------------------------ message -------------------------------

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Fehler 1

------------------------------------ message -------------------------------

Thanks for fixing :)

regards,
   Chriss

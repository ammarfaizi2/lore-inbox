Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbREFWmi>; Sun, 6 May 2001 18:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135908AbREFWm3>; Sun, 6 May 2001 18:42:29 -0400
Received: from web10207.mail.yahoo.com ([216.136.130.71]:46096 "HELO
	web10207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135898AbREFWmV>; Sun, 6 May 2001 18:42:21 -0400
Message-ID: <20010506224220.80532.qmail@web10207.mail.yahoo.com>
Date: Sun, 6 May 2001 15:42:20 -0700 (PDT)
From: sri gg <srimg@yahoo.com>
Subject: problem when booting 2.4.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      I recently compiled the 2.4.2 kernel on x86, 
and installed it. when booting off it, it fails to 
open the /dev/tty's and dumps the following messages..
=========================================
May  6 02:32:40 localhost /sbin/mingetty[786]:
/dev/tty4: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[785]:
/dev/tty3: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[787]:
/dev/tty5: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[788]:
/dev/tty1: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[789]:
/dev/tty2: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[790]:
/dev/tty3: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[793]:
/dev/tty6: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[794]:
/dev/tty1: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[791]:
/dev/tty4: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[795]:
/dev/tty2: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[797]:
/dev/tty5: No such file or direct
ory
May  6 02:32:40 localhost /sbin/mingetty[796]:
/dev/tty3: No such file or direct
============================================
  Because of that, it is not able to get the keyboard
or the mouse.. and everything is hung. It does accept
the ctrl+alt+del to shutdown..

Another question which i wanted to ask was, how does
the new kernel know where to find the new compiled
modules in the /lib/modules directoy? I have my old
modules in /lib/modules/2.2.16, and my new modules 
under /lib/modules/2.4.2.  

Any help or suggestions would be greatly appreciated.
Thanks.
srimg.


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/

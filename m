Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBIUqF>; Fri, 9 Feb 2001 15:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBIUp4>; Fri, 9 Feb 2001 15:45:56 -0500
Received: from t1-11.realtime.net ([205.238.131.11]:51412 "EHLO
	bella.auschron.com") by vger.kernel.org with ESMTP
	id <S129106AbRBIUps>; Fri, 9 Feb 2001 15:45:48 -0500
Date: Fri, 9 Feb 2001 14:45:34 -0600
From: Lindsey Simon <lsimon@auschron.com>
To: linux-kernel@vger.kernel.org
Subject: booting the 2.4.1 linux kernel... tada,nada
Message-ID: <20010209144534.B379@bella.auschron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-OS: Linux bella 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Once I get the loading the kernel message from Lilo I hard crash without any error
messages.
[2.] I had no trouble making the bzImage and have installed it made it and installed it
three different times from scratch, once using debian's make-kpkg tool, but still I get
the same outcome - a hard crash with no error messages. I get the Loading
Linux.2.4.1........... ok,now booting the kernel and then BANG, I go dead with no error
message of any kind.
[3.] kernel
[4.] Linux version 2.2.17 (root@bella) (gcc version 2.95.2 20000220 (Debian GNU/Linux
)) #1 SMP Thu Nov 9 13:54:02 CST 2000
 
[7.] Debian Potato, some testing packages..
[7.1.]
bella:/usr/src/linux_2.4.1# sh scripts/ver_linux 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux bella 2.2.17 #1 SMP Thu Nov 9 13:54:02 CST 2000 i586 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.2.1
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.96
Sh-utils               2.0
Modules Loaded         sb uart401 sound soundcore 3c59x

I upgraded all the packages mentioned in the Changes file and have run out of ideas for
what to try next.. I upgraded lilo thinking that might fix things, but that changed
nothing. Thanks for any help.

--lindsey
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

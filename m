Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269880AbRHEAZj>; Sat, 4 Aug 2001 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269879AbRHEAZ3>; Sat, 4 Aug 2001 20:25:29 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:40718 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269877AbRHEAZV>; Sat, 4 Aug 2001 20:25:21 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Message-ID: <3B6C9279.9080900@yahoo.co.nz>
Date: Sun, 05 Aug 2001 12:25:29 +1200
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Mr Kernel Dude <linux-kernel@vger.kernel.org>
Subject: Error when compiling 2.4.7ac6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c check.c
In file included from check.c:28:
ldm.h:100: warning: `SYS_IND' redefined
ldm.h:84: warning: this is the location of the previous definition
ldm.h:104: warning: `NR_SECTS' redefined
ldm.h:88: warning: this is the location of the previous definition
ldm.h:109: warning: `START_SECT' redefined
ldm.h:92: warning: this is the location of the previous definition
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
pipe -mpreferred-stack-boundary=2 -march=i686    -c -o msdos.o msdos.c
rm -f partitions.o

-- 
I am the blue screen of death
no body can hear your screams


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


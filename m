Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275448AbRJJLaW>; Wed, 10 Oct 2001 07:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275424AbRJJLaN>; Wed, 10 Oct 2001 07:30:13 -0400
Received: from p17-max10.syd.ihug.com.au ([203.173.155.17]:45584 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S275448AbRJJLaE>; Wed, 10 Oct 2001 07:30:04 -0400
Message-ID: <3BC38813.4030601@linuxmail.org>
Date: Wed, 10 Oct 2001 09:28:19 +1000
From: Cyrus <cyrus@linuxmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20011005
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: linux.dev.kernel
To: linux-kernel@vger.kernel.org
Subject: Clock Skew?... kernel compile.....2.4.11...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i was compiling kernel 2.4.11... on my two machines. my server, which is 
an intel p2 233Mhz mmx... went alright without errors....

but my athlon system, 1.2 thunderbird was spewing out this error.

honestly, i've never encountered this one...

Root device is (3, 3)
Boot sector 512 bytes.
Setup is 4640 bytes.
System is 798 kB
make[1]: Leaving directory `/usr/src/linux-2.4.11/arch/i386/boot'
make: warning:  Clock skew detected.  Your build may be incomplete.

real    3m47.334s
user    2m46.510s
sys     0m29.330s


any ideas?... thanks in a lot...


cyrus

-- 
  Cyrus Santos

Registered Slackware Linux User # 220455
Sydney, Australia

"...the best things in life are free...."





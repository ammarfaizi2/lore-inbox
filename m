Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264600AbUEDTTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUEDTTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUEDTTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:19:52 -0400
Received: from smtp.wp.pl ([212.77.101.160]:34599 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264600AbUEDTTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:19:45 -0400
Date: Tue, 4 May 2004 21:19:39 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
Message-Id: <20040504211939.79ed1e6f.rmrmg@wp.pl>
In-Reply-To: <20040503230911.GE7068@logos.cnet>
References: <20040503230911.GE7068@logos.cnet>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__4_May_2004_21_19_39_+0200_EfGbDKMgMjfJIc0v"
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__4_May_2004_21_19_39_+0200_EfGbDKMgMjfJIc0v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

begin  Marcelo Tosatti <marcelo.tosatti@cyclades.com> quote:
 
> Here goes the second pre release of 2.4.27.

make[2]: Entering directory `/usr/src/linux-2.4.27-pre2/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=sched 
-fno-omit-frame-pointer -c -o sched.o sched.c sched.c:213: error:
conflicting types for 'reschedule_idle' sched.c:210: error: previous
declaration of 'reschedule_idle' was here sched.c:213: error:
conflicting types for 'reschedule_idle' sched.c:210: error: previous
declaration of 'reschedule_idle' was here sched.c:371: error:
conflicting types for
'wake_up_process'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:603:
error: previous declaration of 'wake_up_process' was here sched.c:371:
error: conflicting types for
'wake_up_process'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:603:
error: previous declaration of 'wake_up_process' was here sched.c:409:
error: conflicting types for
'schedule_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:148:
error: previous declaration of 'schedule_timeout' was here sched.c:409:
error: conflicting types for
'schedule_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:148:
error: previous declaration of 'schedule_timeout' was here sched.c:739:
error: conflicting types for
'__wake_up'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:595: error:
previous declaration of '__wake_up' was here sched.c:739: error:
conflicting types for
'__wake_up'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:595: error:
previous declaration of '__wake_up' was here sched.c:749: error:
conflicting types for
'__wake_up_sync'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:596:
error: previous declaration of '__wake_up_sync' was here sched.c:749:
error: conflicting types for
'__wake_up_sync'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:596:
error: previous declaration of '__wake_up_sync' was here sched.c:759:
error: conflicting types for
'complete'/usr/src/linux-2.4.27-pre2/include/linux/completion.h:31:
error: previous declaration of 'complete' was here sched.c:759: error:
conflicting types for
'complete'/usr/src/linux-2.4.27-pre2/include/linux/completion.h:31:
error: previous declaration of 'complete' was here sched.c:769: error:
conflicting types for
'wait_for_completion'/usr/src/linux-2.4.27-pre2/include/linux/completio
n.h:30: error: previous declaration of 'wait_for_completion' was here
sched.c:769: error: conflicting types for
'wait_for_completion'/usr/src/linux-2.4.27-pre2/include/linux/completio
n.h:30: error: previous declaration of 'wait_for_completion' was here
sched.c:804: error: conflicting types for
'interruptible_sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.
h:600: error: previous declaration of 'interruptible_sleep_on' was here
sched.c:804: error: conflicting types for
'interruptible_sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.
h:600: error: previous declaration of 'interruptible_sleep_on' was here
sched.c:815: error: conflicting types for
'interruptible_sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linu
x/sched.h:601: error: previous declaration of
'interruptible_sleep_on_timeout' was here sched.c:815: error:
conflicting types for
'interruptible_sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linu
x/sched.h:601: error: previous declaration of
'interruptible_sleep_on_timeout' was here sched.c:828: error:
conflicting types for
'sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:597: error:
previous declaration of 'sleep_on' was here sched.c:828: error:
conflicting types for
'sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:597: error:
previous declaration of 'sleep_on' was here sched.c:839: error:
conflicting types for
'sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:598:
error: previous declaration of 'sleep_on_timeout' was here sched.c:839:
error: conflicting types for
'sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:598:
error: previous declaration of 'sleep_on_timeout' was here sched.c:210:
warning: 'reschedule_idle' declared `static' but never defined make[2]:
*** [sched.o] Error 1 make[2]: Leaving directory
`/usr/src/linux-2.4.27-pre2/kernel' make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.27-pre2/kernel'
make: *** [_dir_kernel] Error 2
[root@slack:/usr/src/linux-2.4.27-pre2#] 


This problem exist when i use GCC-3.4.0, GCC-3.2.3 doesn't cause it.



-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .

--Multipart=_Tue__4_May_2004_21_19_39_+0200_EfGbDKMgMjfJIc0v
Content-Type: application/octet-stream;
 name=".config.bz2"
Content-Disposition: attachment;
 filename=".config.bz2"
Content-Transfer-Encoding: base64

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
AP795AAFGEMr6sF2q7Varzt5i7kinChIdrj+LoA=

--Multipart=_Tue__4_May_2004_21_19_39_+0200_EfGbDKMgMjfJIc0v--

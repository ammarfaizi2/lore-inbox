Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSHNOMb>; Wed, 14 Aug 2002 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSHNOMb>; Wed, 14 Aug 2002 10:12:31 -0400
Received: from benning-emh7.army.mil ([150.226.16.20]:59913 "EHLO MDOIMEMH9")
	by vger.kernel.org with ESMTP id <S318696AbSHNOMa>;
	Wed, 14 Aug 2002 10:12:30 -0400
Message-ID: <3D5A673B.1000702@benning.army.mil>
Date: Wed, 14 Aug 2002 10:20:43 -0400
From: Bob Kruger <krugerb@benning.army.mil>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  Printing output corrupted using kernel 2.4.19.
2.  Print output from three Linux servers corrupted.  These servers are 
running Samba 2.2.5, and are Slackware 8.0 or 8.1 systems.  Print output 
from Windows platforms, especially .pdf files, gets corrupted.  Half 
pages are printed.  Pages are repeated, etc.  Drop back to the 2.4.18 
kernel, and the problem goes away.  Kernel on all systems compiled 
locally, e.g. on each system.  Print daemon is from the LPRng package. 
 Printers include TCP/IP printers (LPRng redirect using printcap) and 
those attached via parallel ports.  Windows systems include XP, 2000, 
and 98.  Regardless of the OS, the printer output is corrupted w/ 2.4.19 
kernel, but works fine when kernel 2.4.18 is run.
3.  Kernel, printing
4.  Kernel version - 2.4.19
5.  Output - no error messages reported
6.  Shell Script - not applicable.
7.  Environment:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux wdbbl080104 2.4.19 #2 SMP Mon Aug 12 10:31:39 EDT 2002 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.16
e2fsprogs              1.19
reiserfsprogs          3.x.0b
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         bsd_comp ppp_generic slhc slip

No module info necessary, as lp is compiled as part of the kernel.

If any other info is needed, please let me know.

As always, my thanks for your hard work.  

Regards - Bob Kruger


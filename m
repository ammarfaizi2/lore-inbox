Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282781AbRLGGkd>; Fri, 7 Dec 2001 01:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282778AbRLGGkY>; Fri, 7 Dec 2001 01:40:24 -0500
Received: from web11403.mail.yahoo.com ([216.136.131.233]:32547 "HELO
	web11403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282781AbRLGGkM>; Fri, 7 Dec 2001 01:40:12 -0500
Message-ID: <20011207064010.5879.qmail@web11403.mail.yahoo.com>
Date: Thu, 6 Dec 2001 22:40:10 -0800 (PST)
From: Abhishek Rai <abbashake007@yahoo.com>
Subject: Qusestion: printk
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

printk works erratically on my machine:

the same module with the same kernel priority flag for
printk (eg. KERN_INFO, KERN_EMERG etc) when insmoded
one time will have printk working just fine. but say
the next time  the comp boots, or even i rmmod it and
reinsert, printk won't print anything. 
however in one lifetime of the module, the behaviour
is consistent- either all the printk's work all don't
work.

-abhishek


=====
Don't say Goodbye say Goodluck
============================================================
Abhishek Rai
3rd year,B.Tech, Computer Science and Engineering
IIT KGP,India
abbashake007@yahoo.com
============================================================


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com

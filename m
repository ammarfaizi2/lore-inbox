Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281811AbRLGPGz>; Fri, 7 Dec 2001 10:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGPFz>; Fri, 7 Dec 2001 10:05:55 -0500
Received: from ns1.jasper.com ([64.19.21.34]:26833 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S281795AbRLGPFn>;
	Fri, 7 Dec 2001 10:05:43 -0500
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: "Abhishek Rai" <abbashake007@yahoo.com>,
        "Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Qusestion: printk
Date: Fri, 7 Dec 2001 09:02:35 -0600
Message-ID: <BOEOJGNGENIJJMAOLHHCAEENCLAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20011207064010.5879.qmail@web11403.mail.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same happened to me and what I did is to restart syslog. Try it

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Abhishek Rai
Sent: Friday, December 07, 2001 12:40 AM
To: Kernel
Subject: Qusestion: printk


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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


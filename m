Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSLQUTb>; Tue, 17 Dec 2002 15:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSLQUTb>; Tue, 17 Dec 2002 15:19:31 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:47881 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267110AbSLQUT3>; Tue, 17 Dec 2002 15:19:29 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: <redhat-devel-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problem Compiling Linux Kernel 2.4.20
Date: Tue, 17 Dec 2002 14:27:32 -0600
Message-ID: <002901c2a60a$bbb65e10$b273d73f@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1040146480.5653.0.camel@stantz.corp.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It (make xconfig) works fine on the 2.4.18-3 kernel that comes pre-installed
with Redhat 7.3.  It just doesn't work with the kernel I downloaded from
http://www.kernel.org (version 2.4.20).

-----Original Message-----
From: redhat-devel-list-admin@redhat.com
[mailto:redhat-devel-list-admin@redhat.com] On Behalf Of Florin Andrei
Sent: Tuesday, December 17, 2002 11:35 AM
To: redhat-devel-list@redhat.com
Subject: RE: Problem Compiling Linux Kernel 2.4.20

On Mon, 2002-12-16 at 14:45, Joseph D. Wagner wrote:
> 
> [root@localhost linux-2.4.20]# make xconfig
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> -: 6: unknown command
> make[1]: *** [kconfig.tk] Error 1

Did you installed the Tcl and Tk stuff?

-- 
Florin Andrei

When it comes to discussing Linux, some people become temporarily
insane.



_______________________________________________
Redhat-devel-list mailing list
Redhat-devel-list@redhat.com
https://listman.redhat.com/mailman/listinfo/redhat-devel-list


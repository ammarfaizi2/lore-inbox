Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTAISGn>; Thu, 9 Jan 2003 13:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTAISGn>; Thu, 9 Jan 2003 13:06:43 -0500
Received: from surfer.sbm.temple.edu ([155.247.185.2]:53332 "EHLO
	surfer.sbm.temple.edu") by vger.kernel.org with ESMTP
	id <S266926AbTAISGm>; Thu, 9 Jan 2003 13:06:42 -0500
Date: Thu, 9 Jan 2003 13:15:21 -0500
From: AU <au@sbm.temple.edu>
To: <Suse-linux-e@suse.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question on SMP (super micro 370dl3)
In-Reply-To: <1042137928.27796.48.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SGI.4.32.0301091306560.9053070-100000@surfer.sbm.temple.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question with my linux box. I am using supermicro 370dl3, dual
1GHz. 2 HD one on scsi aic-7892, the other one on Promise 100 TX2.
I am running SuSE 8.0, current kernel version is 2.4.18, coming with
installation. Now I am try to upgrade to 2.4.19. However, I use the 2.4.19
from ftp://ftp.suse.com/pub/people/mantel/linux-2.4.19-41.tar.bz2. It
doest boot up right. when it detect hd on pdc20268 then it give me "lost
interrupt" message. This message can go away if I use command line
"noapic" at boot prompt.
So, I switch to 2.4.19 from ftp.kernel.edu, then this kernel it boot fine
without any argument at boot prompt.

Can anybody guide me to make 2.4.19 from suse ftp site work without put
"noapic" at boot prompt.


One more thing this machine can not shutdown, even it is atx case. I tried
to put acpi on but it give me some table name error.

Thank you.
+AU


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319750AbSIMSmY>; Fri, 13 Sep 2002 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319749AbSIMSmY>; Fri, 13 Sep 2002 14:42:24 -0400
Received: from web13205.mail.yahoo.com ([216.136.174.190]:56840 "HELO
	web13205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319750AbSIMSmX>; Fri, 13 Sep 2002 14:42:23 -0400
Message-ID: <20020913184715.62063.qmail@web13205.mail.yahoo.com>
Date: Fri, 13 Sep 2002 11:47:15 -0700 (PDT)
From: Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Configuring kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Linux RedHat 7.1 installed on my machine which
has a kernel version 2.4.2. I have to run a software
called iSCSI for which I need a lower kernel version
2.4.16.
I downloaded the sofware and opened it in the /usr/src
directory. I did the following
1. unzipped the tar file
2. mv linux linux-2.4.16
3 ln -s linux-2.4.16 linux
4. changed to linux directory and issued the command
make mproper.
Then when I issued the command make xconfig I was
getting errors. I got similar errors when I tried to
use the following commands make menuconfig, make
config.
When I used the command uname -i I still was getting
the kernel version as 2.4.2.
I do not know why this error is coming.               
      
Kindly please help.
Regards,
Srinivas Chavva

__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com

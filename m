Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTAWLHI>; Thu, 23 Jan 2003 06:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTAWLHI>; Thu, 23 Jan 2003 06:07:08 -0500
Received: from ftp.gdufs.edu.cn ([202.116.192.38]:54426 "EHLO
	mailsvr.gdufs.edu.cn") by vger.kernel.org with ESMTP
	id <S265096AbTAWLHH>; Thu, 23 Jan 2003 06:07:07 -0500
Message-ID: <005101c2c2d1$3a5b2380$81df74ca@hammer>
From: "Yao Minfeng" <yaomf@gdufs.edu.cn>
To: <linux-kernel@vger.kernel.org>
Subject: new kernel fail
Date: Thu, 23 Jan 2003 19:18:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

I am rather new to Linux, but really want to have a try. I am running RedHat
7.2 with the kernel of
2.4.7-10. I just compiled the 2.4.12 and 2.4.16 Kernel, however, when I
login to the system, I found that

1)

Login: root
Passwd:

bash: id: Command not found
bash: id: Command not found
bash: id: Command not found

[: Too many arguments

...


2) all the files under /home, /usr are missing, this happens both for 2.4.12
and 2.4.16, but when I login back to 2.4.7-10, the files are there again, I
can't figure it out.

Any help is welcome.

Thanks.




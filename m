Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272008AbRIIPiq>; Sun, 9 Sep 2001 11:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRIIPih>; Sun, 9 Sep 2001 11:38:37 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:60650 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S272008AbRIIPiZ>; Sun, 9 Sep 2001 11:38:25 -0400
Message-ID: <00b301c1387b$a5b7bee0$0200a8c0@lazybrain.com>
From: "faybaby" <faybaby@enter.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9 modules + unresovled symbols
Date: Sat, 8 Sep 2001 11:33:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I haven't had any trouble upgrading the kernel til now.
the problem is this. i can't load 80% of the modules i compiled.
  

I have tried alot of things. depmod -a depmod this, depmod that.

i did rm -rf /lib/modules/2.4.9 & /usr/src/linux , rextracted the kernel,
configured and compiled it. it boots fine, i just can't load anything.
im running mandrake 7.2.
i did make clean, make mrproper a few times that didnt help.
i download 2.4.9 again and started over with the same results.
I even downloaded 2.4.6 and tried it, but produced the same results.
Im currently running 2.4.6 that works fine, .

whats wrong and how do i fix it. thanks everyone





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSBJQsF>; Sun, 10 Feb 2002 11:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSBJQrz>; Sun, 10 Feb 2002 11:47:55 -0500
Received: from [61.140.60.248] ([61.140.60.248]:42787 "HELO 21cn.com")
	by vger.kernel.org with SMTP id <S289694AbSBJQrq>;
	Sun, 10 Feb 2002 11:47:46 -0500
Date: Mon, 11 Feb 2002 0:50:2 +0800
From: Laurence <laudney@21cn.com>
Reply-To: laudney@21cn.com
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Transaction TCP patch for Linux
Organization: SJTU
X-mailer: FoxMail 4.0 beta 1 [cn]
Message-Id: <20020210164754Z289694-13996+20348@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to be emailed comments or replies personally.

Transaction TCP is an extension for TCP. Its performance advantage is
indisputably better than standard TCP. But only FreeBSD integrates
TTCP into its kernel. So, I've started T/TCP for Linux at
http://ttcplinux.sourceforge.net or
http://sourceforge.net/projects/ttcplinux. I'm writing the kernel
patch for Linux kernel 2.4.2. Is anyone interested in it or have
anything to say about T/TCP's pros and cons??

Besides, I've finished some basic codes involving:
1. new structures
2. newly created or modified funtions mainly related to receiving

If anyone is interested, tell me and I'll send the codes. I don't want to upload the codes in CVS at this moment. At least, I want to have a basic but compile-able one.



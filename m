Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbTCNLEi>; Fri, 14 Mar 2003 06:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbTCNLEi>; Fri, 14 Mar 2003 06:04:38 -0500
Received: from web40610.mail.yahoo.com ([66.218.78.147]:37980 "HELO
	web40610.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261697AbTCNLEh>; Fri, 14 Mar 2003 06:04:37 -0500
Message-ID: <20030314111503.2792.qmail@web40610.mail.yahoo.com>
Date: Fri, 14 Mar 2003 12:15:03 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Panic with 2.5.64-mm
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Kernel 2.5.64 with mm patches dies with "kernel panic,
killing interrupt handler" when ejecting cdrom 
(with eject /dev/hdc). 

System is duron 700 Mhz with via kt133 cipset and 
radeon ve video card. 

I didn't had time to copy the panic message but if 
you can't reproduce it (for me is 100% reproductible)
i'll send it to you. Programs and glibc are the same 
as in linux/Documentation/Changes or newer.


I'll try tomorrow to send the full Panic message to you.

Bye
Calin


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com

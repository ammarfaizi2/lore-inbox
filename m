Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbSJBOWq>; Wed, 2 Oct 2002 10:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbSJBOWq>; Wed, 2 Oct 2002 10:22:46 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:44553 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S263099AbSJBOWp>; Wed, 2 Oct 2002 10:22:45 -0400
Message-ID: <006901c26a1f$db35c5e0$76c211d0@ferrari>
From: "Vivek Srivastava" <vivs@vt.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Recompiling kernel 2.4.7-10
Date: Wed, 2 Oct 2002 10:27:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Group,
I am a newbie to Linux. I have Linux Rh 7.2 installed on my Dell Latitude
C640 Laptop. It is partitioned with Win 2K professional as the other OS. I
included some Xircom and Cisco WLAN card modules in the kernel configuration
and recompiled the kernel. A problem then came up when I rebooted my machine
with the new kernel. It failed to mount my root file system.
I then included the ext3 file system module with the kernel and then
recompiled it and rebooted it again.
It still did not boot up and gave me a " Root fs did not mount " and the
booting process just stays there doing nothing. I did the same thing on my
second Dell C640 Latitude notebook and it gave me the same problem.
Any help in this matter would be appreciated.
Regards,
Vivek.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264486AbSIQTXU>; Tue, 17 Sep 2002 15:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbSIQTXU>; Tue, 17 Sep 2002 15:23:20 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:56518 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S264486AbSIQTXU>; Tue, 17 Sep 2002 15:23:20 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A60@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Linux hot swap support
Date: Tue, 17 Sep 2002 15:28:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a cPCI system running a Red Hat 2.4.18-3 Kernel. am running on a
Pentium III 700Mhz machine, but we have some of our own cPCI HW. I wrote the
drivers according to the Linux Device Driver 2nd edition (i.e. hot swap
compliant). But what I am missing is :

What SW will call my device insert/device remove routines?
Do I need some 3rd party SW?


Please CC me directly on anty response. By the way I read the PDF file  Hot
Pluggable Devices And The Linux Kernel, but I am still not clear on the
answerrs to the above questions.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


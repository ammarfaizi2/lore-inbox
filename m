Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261633AbTCQMHx>; Mon, 17 Mar 2003 07:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCQMHx>; Mon, 17 Mar 2003 07:07:53 -0500
Received: from [203.124.139.208] ([203.124.139.208]:25414 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id <S261633AbTCQMHw>;
	Mon, 17 Mar 2003 07:07:52 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Read Hat 7.3 and 8.0 compilation problems
Date: Mon, 17 Mar 2003 18:17:50 +0530
Message-ID: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a driver which was originally bulit on Red Hat 7.2 version.Now we
are compiling the same driver on Red Hat 7.3 and 8.0
While compiling we are facing the following problems.
Compilation output :-
The following files are missing
/usr/include/asm/msr.h
/usr/include/asm/fixmap.h
/usr/include/asm/uaccess.h
/usr/include/asm/hardirq.h

But if we compile the driver using the include souces
/usr/src/linux-2.4/include we do not get any compilation errors.
Also our driver when compiled on Red Hat 7.2 does not give any compilation
problems.

Pls help.

Thanks and Regards
Chandrasekhar


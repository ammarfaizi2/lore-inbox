Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbRCJO0t>; Sat, 10 Mar 2001 09:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbRCJO0j>; Sat, 10 Mar 2001 09:26:39 -0500
Received: from ddsl.net ([202.9.145.10]:14599 "EHLO eth.net")
	by vger.kernel.org with ESMTP id <S130462AbRCJO0U> convert rfc822-to-8bit;
	Sat, 10 Mar 2001 09:26:20 -0500
Message-ID: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii>
From: "Srinath Ravinathan" <sriguhan@eth.net>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.1 on RHL 6.2
Date: Sat, 10 Mar 2001 20:16:34 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I'm trying to compile kernel 2.4.1 on RedHat 6.2 (zoot). After the make xconfig and make dep when I give make bzlilo I get the following error message

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o 
scripts/split-include
scripts/split-include.c
In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
make: *** [scripts/split-include] Error 1

What should I do?
Yours ,
Srinath.R



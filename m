Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRILKzU>; Wed, 12 Sep 2001 06:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272744AbRILKzJ>; Wed, 12 Sep 2001 06:55:09 -0400
Received: from picard.csihq.com ([204.17.222.1]:706 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S272737AbRILKzA>;
	Wed, 12 Sep 2001 06:55:00 -0400
Message-ID: <00d301c13b79$56982e20$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Bug still on 2.4.10?
Date: Wed, 12 Sep 2001 06:54:46 -0400
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

This is on 2.4.8 but I get the funny feeling this maybe hasn't been fixed
yet for 2.4.10:

Sep 11 06:58:08 yeti kernel: md: fsck.ext3(pid 151) used obsolete MD
ioctl(4717), upgrade your software to use new ictls.
I'm runing:
Parallelizing fsck version 1.23 (15-Aug-2001)
Unless maybe I just need to recompile it???

Here's a previous reference I found from Jan 2001.
http://oss.sgi.com/projects/xfs/mail_archive/0101/msg00185.html

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355


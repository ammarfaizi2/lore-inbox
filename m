Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRDODjx>; Sat, 14 Apr 2001 23:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDODjn>; Sat, 14 Apr 2001 23:39:43 -0400
Received: from mail.gator.com ([63.197.87.182]:17419 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132565AbRDODjg>;
	Sat, 14 Apr 2001 23:39:36 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: Disorder?
Date: Sat, 14 Apr 2001 20:39:34 -0700
Message-ID: <CHEKKPICCNOGICGMDODJGENKCLAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's all this in syslog? I don't remember ever seeing it there before.

...
Apr 14 13:58:31 foo kernel: Disorder0 3 5 f0 s2 rr1
Apr 14 13:58:32 foo kernel: Disorder0 3 5 f0 s1 rr1
Apr 14 13:58:41 foo kernel: Disorder0 3 8 f0 s0 rr1
Apr 14 13:58:44 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:58:45 foo kernel: Disorder0 3 4 f0 s0 rr1
Apr 14 13:58:47 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:58:55 foo kernel: Disorder3 1 5 f5 s2 rr0
Apr 14 13:58:59 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p3
Apr 14 13:59:00 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:01 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:02 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p2
Apr 14 13:59:02 foo kernel: Disorder0 3 4 f0 s0 rr1
Apr 14 13:59:03 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p1
Apr 14 13:59:04 foo kernel: Undo retrans 145.236.164.120/2007 c2 l0 ss2/2
p0
Apr 14 13:59:11 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:15 foo kernel: Disorder0 3 4 f0 s0 rr1
Apr 14 13:59:17 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:19 foo kernel: Disorder0 3 4 f0 s0 rr1
Apr 14 13:59:21 foo kernel: Disorder0 3 4 f0 s0 rr1
Apr 14 13:59:24 foo kernel: Disorder0 3 7 f0 s0 rr1
Apr 14 13:59:25 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:37 foo kernel: Disorder0 3 5 f0 s0 rr1
Apr 14 13:59:57 foo kernel: Disorder3 1 5 f5 s2 rr0
...

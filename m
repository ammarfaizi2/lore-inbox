Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSEVOA3>; Wed, 22 May 2002 10:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSEVOA1>; Wed, 22 May 2002 10:00:27 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:45223 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313898AbSEVOAI>; Wed, 22 May 2002 10:00:08 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Have the 2.4 kernel memory management problems on large machines been fixed?
Date: Wed, 22 May 2002 07:00:11 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBGEBEENAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020522085111.C20554@ds217-115-141-141.dedicated.hosteurope.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago, there was a flurry of reports from people having
difficulties with memory management on large machines (ia32 over 4 GB). I've
seen a lot of 2.4.x-yy kernels go by and much VM discussion, but what I'm
*not* seeing is reports of either catastrophic behavior or its absence on
large machines. I haven't had a chance to run my own test cases on the
2.4.18 kernel from Red Hat 7.3 yet, so I can't make any personal
contribution to this discussion.
--
M. Edward Borasky
http://www.borasky-research.net/HarryIannis.htm
znmeb@aracnet.com



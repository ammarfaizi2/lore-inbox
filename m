Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbRAGRWY>; Sun, 7 Jan 2001 12:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136063AbRAGRWP>; Sun, 7 Jan 2001 12:22:15 -0500
Received: from celticclans.com ([216.181.87.36]:41989 "EHLO celticclans.com")
	by vger.kernel.org with ESMTP id <S136009AbRAGRWB>;
	Sun, 7 Jan 2001 12:22:01 -0500
Message-Id: <5.0.2.1.2.20010107121926.03587280@sirius.onopordon.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 07 Jan 2001 12:21:58 -0500
To: Scott Laird <laird@internap.com>
From: Jeff Forbes <jgf@stellarhost.com>
Subject: Re: PROBLEM with raid5 and 2.4.0 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101070842391.13842-100000@lairdtest1.intern
 ap.com>
In-Reply-To: <5.0.2.1.2.20010107112405.03223780@celticclans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure enough, when I changed the processor type from
Pentium-Pro/Celeron/Pentium-II
to
Pentium-III
(which is the type of processor in the machine) it works.


At 08:43 AM 01/07/2001 -0800, Scott Laird wrote:

>It works if you compile the kernel with the processor type set to Pentium
>II or higher, or disable RAID5.  I've been meaning to report this one, but
>2.4.0 was released before I had time to test the last prerelease, and I
>haven't had time to test the final release yet.

Jeffrey Forbes, Ph.D.
http://www.stellarhost.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

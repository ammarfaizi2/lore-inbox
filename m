Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282292AbRKWXuZ>; Fri, 23 Nov 2001 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282287AbRKWXuP>; Fri, 23 Nov 2001 18:50:15 -0500
Received: from outmail6.pacificnet.net ([207.171.0.134]:60723 "EHLO
	outmail6.pacificnet.net") by vger.kernel.org with ESMTP
	id <S282289AbRKWXuG>; Fri, 23 Nov 2001 18:50:06 -0500
Message-ID: <013601c17479$933f0450$2b910404@Molybdenum>
From: "Jahn Veach" <V64@Galaxy42.com>
To: <linux-kernel@vger.kernel.org>
Cc: <viro@math.psu.edu>
Subject: Re: 2.4.15 + fs corruption.
Date: Fri, 23 Nov 2001 17:50:03 -0600
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

> Breakage happens when you umount filesystem (_any_ local filesystem, be
> it ext2, reiserfs, whatever) that still has dirty inodes.

What kind of breakage are we looking at here? I had a system that ran 2.4.15
and got shut down without a sync. What kind of corruption will occur and is
it something a simple fsck will fix?


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKOCxt>; Tue, 14 Nov 2000 21:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQKOCxj>; Tue, 14 Nov 2000 21:53:39 -0500
Received: from h00059aa0e40d.ne.mediaone.net ([24.91.9.69]:28150 "EHLO
	flowers.house.larsshack.org") by vger.kernel.org with ESMTP
	id <S129060AbQKOCxg>; Tue, 14 Nov 2000 21:53:36 -0500
Date: Tue, 14 Nov 2000 21:23:36 -0500 (EST)
From: Lars Kellogg-Stedman <lars@larsshack.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Whither sparc bugs?
Message-ID: <Pine.LNX.4.21.0011142119460.24272-100000@flowers>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently run into what look like some kernel bugs[1] in the 2.2.17
kernel (on a sparcstation 2 (sun4c) and a javasation (sun4m)).  I've
posted them to the sparclinux mailing list, but I was wondering if there
was somewhere else (e.g., here) that I should send them.

Is there anyone actively maintaining the sparc port?

Thanks,

  -- Lars

[1] kernel oops on the javastation triggered by mis-detected floppy drive,
    and memory allocation issues on the sparcstation 2 that result in
    kmem_cache_alloc() failing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

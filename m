Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314721AbSDVT5d>; Mon, 22 Apr 2002 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314720AbSDVT5c>; Mon, 22 Apr 2002 15:57:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25264 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314698AbSDVT4t>;
	Mon, 22 Apr 2002 15:56:49 -0400
Date: Mon, 22 Apr 2002 15:56:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Hanna Linder <hannal@us.ibm.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [CFT][PATCH] (1/5) sane procfs/dcache interaction
In-Reply-To: <13910000.1019501919@w-hlinder.des>
Message-ID: <Pine.GSO.4.21.0204221516060.4337-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Hanna Linder wrote:

> Patch 1 of 5 failed to apply to 2.5.8.
> Which version are these built against?

???

Applies clean to 2.5.8 here.  md5 of files in question:

ed29a4584c15c347ac21362e9359d204  C8/kernel/exit.c
266abe14ebf56a6c54b750f1250d98dd  C8/include/linux/sched.h

(15 minutes later) md5 of these files in tree from ftp.kernel.org:
ed29a4584c15c347ac21362e9359d204  linux-2.5.8/kernel/exit.c
266abe14ebf56a6c54b750f1250d98dd  linux-2.5.8/include/linux/sched.h

Check your tree...


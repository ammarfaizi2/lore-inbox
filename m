Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSEQDuA>; Thu, 16 May 2002 23:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSEQDt7>; Thu, 16 May 2002 23:49:59 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:49167 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315412AbSEQDt5>;
	Thu, 16 May 2002 23:49:57 -0400
Date: Fri, 17 May 2002 04:49:52 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Updated Commentry Patches
Message-ID: <Pine.LNX.4.44.0205170429130.29254-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated four previous patches (previously against pre7) that try to
comment and document how the VM in 2.4.19pre8 works. I've posted them
before on the list so I'm just going to include URL's this time. They are

2.4.19pre8_documentation_numa
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.19pre8_documentation_numa
  Extends the Documentation/vm/numa file to try and describe NUMA and
  related data structures a bit better

2.4.19pre8_page_alloc_commentry
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.19pre8_page_alloc_commentry
  This extends the documentation on page_alloc.c to describe how the buddy
  allocator works

2.4.19pre8_slab_commentry
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.19pre8_slab_commentry
  Extends the commentry on the slab allocator slightly

2.4.19pre8_vmalloc_commentry
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.19pre8_vmalloc_commentry
  Documents how vmalloc works

If there is no complaints, I'll see what I can do about getting them
integrated into the main branch. Thanks to all those who provided feedback
with them

-- 
		Mel Gorman



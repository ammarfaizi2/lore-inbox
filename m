Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSHQX5T>; Sat, 17 Aug 2002 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318776AbSHQX5T>; Sat, 17 Aug 2002 19:57:19 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15881 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S318775AbSHQX5S>;
	Sat, 17 Aug 2002 19:57:18 -0400
Date: Sun, 18 Aug 2002 01:01:12 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Re: VM Regress 0.5 - Compile error with CONFIG_HIGHMEM
In-Reply-To: <20020817132153.A11758@infradead.org>
Message-ID: <Pine.LNX.4.44.0208180058530.15099-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Christoph Hellwig wrote:

> Shouldn't an undonditional #include <linux/highmem.h> do it much cleaner?
>

I imagine so, but I had a bus to catch and didn't have time to verify if
they were files that should be unconditionally included. As it will be
Monday before I'm working again, I choose the safe option

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSEUVyV>; Tue, 21 May 2002 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSEUVyU>; Tue, 21 May 2002 17:54:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61176 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315447AbSEUVyS>;
	Tue, 21 May 2002 17:54:18 -0400
Date: Tue, 21 May 2002 14:54:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffermem_pages removal (5/5)
Message-ID: <332390000.1022018052@flay>
In-Reply-To: <3CEA9193.10F45174@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, vaguely.  Haven't thought about it a lot.  I suspect the
> present kmap() infrastructure would collapse under the load,
> so surgery there would be needed first.

Hopefully I'll have that surgery completed this week, or early
next week, assuming the per-address space kmap is sufficient
for what you're looking at.

M.



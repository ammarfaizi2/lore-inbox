Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUHZU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUHZU26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbUHZUMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:12:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16274 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269495AbUHZUE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:04:56 -0400
Date: Thu, 26 Aug 2004 13:04:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>
cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <23320000.1093550657@flay>
In-Reply-To: <412D9FE6.9050307@namesys.com>
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't move reiser4 into vfs, use reiser4 as the vfs. 

Ah ... that seems to be a good insight into what you're driving for.
That would seem to be good for you ... and bad for other filesystems.
So whilst I can see why you'd want it - but I don't think it's a good idea.
Competition is good.

Andrew wrote:

> And what are the licensing implications of plugins?  Are they derived
> works?  Must they be GPL'ed?

You replied:

>>And what are the licensing implications of plugins?  Are they derived
>>works?  
>
> Yes.

I find it odd that you cut out the last part of his question. So must
they be GPL'ed or not?

M.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314374AbSDRPQX>; Thu, 18 Apr 2002 11:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314375AbSDRPQW>; Thu, 18 Apr 2002 11:16:22 -0400
Received: from slip-202-135-75-31.ca.au.prserv.net ([202.135.75.31]:43918 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314374AbSDRPQW>; Thu, 18 Apr 2002 11:16:22 -0400
Date: Fri, 19 Apr 2002 01:17:36 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, hannal@us.ibm.com
Subject: Re: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache
Message-Id: <20020419011736.72e666fd.rusty@rustcorp.com.au>
In-Reply-To: <20020418081843.GE4209@krispykreme>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 18:18:43 +1000
Anton Blanchard <anton@samba.org> wrote:
> 1. On 2.5.9, lru_list_lock contention starts to cut in at 4 cpus.
> Andrew's dalloc work gets rid of this bottleneck completely. Its fantastic
> stuff!

Agreed.

Just wanted to state for the public record: Andrew Morton is a God,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

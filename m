Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314393AbSDTAwP>; Fri, 19 Apr 2002 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314413AbSDTAwO>; Fri, 19 Apr 2002 20:52:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43153 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314393AbSDTAwM>;
	Fri, 19 Apr 2002 20:52:12 -0400
Date: Sat, 20 Apr 2002 10:50:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: Re: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache
Message-ID: <20020420005011.GA21850@krispykreme>
In-Reply-To: <20020418081843.GE4209@krispykreme> <3CBE8AAA.FD940076@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The code Anton tested was the removal of the buffer LRUs and
> the buffer hashtable and the introduction of address_space-based
> writeback.  That code is >this< close to being ready.  Still
> chasing a couple of oddities.

http://samba.org/~anton/linux/2.5.9/

GOLD FOR AUSTRALIA!

The latest results include updates to dallocbase-70-writeback and a
per cpu page cache, both from Andrew.

Anton

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSHKCrO>; Sat, 10 Aug 2002 22:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317491AbSHKCrO>; Sat, 10 Aug 2002 22:47:14 -0400
Received: from smtp.comcast.net ([24.153.64.2]:39467 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S317427AbSHKCrO>;
	Sat, 10 Aug 2002 22:47:14 -0400
Date: Sat, 10 Aug 2002 22:50:18 -0400
From: Tom Vier <tmv@comcast.net>
Subject: Re: Testing of filesystems
In-reply-to: <20020730094902.GA257@prester.freenet.de>
To: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
       linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20020811025018.GE17886@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <20020730094902.GA257@prester.freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> I wonder what a good way is to stress test my JFS filesystem. Is there a tool
<snip>

fsx.c came up a while ago on l-k. it's an old (but still very useful) fs
stressor(sp) from neXT. i have a copy davej modded for linux. if you can't
find it, i can send it to you. i haven't been brave enough to run it myself,
on my alpha's reiserfs. 8) it found some hard to find bugs in ext2 that were
lurking for years (iirc).

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA

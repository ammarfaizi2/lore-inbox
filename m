Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289876AbSAOO7O>; Tue, 15 Jan 2002 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289881AbSAOO7E>; Tue, 15 Jan 2002 09:59:04 -0500
Received: from ppp97.c5300-2.day-oh.siscom.net ([209.251.10.97]:21385 "EHLO
	leros.siscom.net") by vger.kernel.org with ESMTP id <S289876AbSAOO6x>;
	Tue, 15 Jan 2002 09:58:53 -0500
Message-Id: <200201151457.JAA14431@leros.siscom.net>
Date: Tue, 15 Jan 2002 09:57:54 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: Significant Slowdown Occuring in 2.2 starting with 19pre2
From: Steve Sheftic <kern0201@siscom.net>
In-Reply-To: <p733d17kcdv.fsf@oldwotan.suse.de>
X-Mailer: Ishmail 2.0.0-20010107-i586-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Also the merge of blkdev-in-pagecache. If the magneto optical disk
> has a weird blocksize < PAGE_CACHE_SIZE (doesn't it have 2k normally?)
> then there could be problems.
> 

I neglected to mention that. Yes, the media I am using has a 2k
blocksize.

And 2.4.17 is working great - this is only happening with recent 2.2.

Steve


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSKVLyz>; Fri, 22 Nov 2002 06:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSKVLyz>; Fri, 22 Nov 2002 06:54:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41959 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264686AbSKVLyy>;
	Fri, 22 Nov 2002 06:54:54 -0500
Date: Fri, 22 Nov 2002 13:01:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48bk3: OOPS: Unable to handle kernel paging request
Message-ID: <20021122120151.GK11884@suse.de>
References: <arl62a$m5a$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arl62a$m5a$1@ncc1701.cistron.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22 2002, Miquel van Smoorenburg wrote:
> 
> This is still the same NNTP news server. I've loaded 2.5.48bk3,
> since it died with 2.5.46bk3 during my vacation and crashes of
> a few releases ago are probably not that interesting.

Most likely fixed by:

http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.48/2.5.48-mm1/broken-out/plugbug.patch

-- 
Jens Axboe


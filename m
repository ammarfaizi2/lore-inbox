Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRCCPLh>; Sat, 3 Mar 2001 10:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRCCPL1>; Sat, 3 Mar 2001 10:11:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59409 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129534AbRCCPLG>;
	Sat, 3 Mar 2001 10:11:06 -0500
Date: Sat, 3 Mar 2001 16:10:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Steven Brooks <umbrook0@cs.umanitoba.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: block loop device hangs
Message-ID: <20010303161044.F2528@suse.de>
In-Reply-To: <3AA10876.7050906@cs.umanitoba.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AA10876.7050906@cs.umanitoba.ca>; from umbrook0@cs.umanitoba.ca on Sat, Mar 03, 2001 at 09:06:30AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03 2001, Steven Brooks wrote:
> When mounting a file using the loopback device, the mount program hangs
> for ever.  Other than that, the system is still usable.

Please read lkml archives before posting, this problem has been
all over the list for the past two weeks.

Use the latest 2.4.2-ac or wait for 2.4.3-pre2

-- 
Jens Axboe


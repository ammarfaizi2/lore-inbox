Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJAOf1>; Tue, 1 Oct 2002 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSJAOf1>; Tue, 1 Oct 2002 10:35:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32927 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261645AbSJAOf0>;
	Tue, 1 Oct 2002 10:35:26 -0400
Date: Tue, 1 Oct 2002 16:40:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001144036.GV3867@suse.de>
References: <20021001140639.GA25624@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001140639.GA25624@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Joe Thornber wrote:
> bk://device-mapper.bkbits.net/2.5-remove-lvm
> 
> This large patch completely removes LVM from the 2.5 tree.  Please
> apply.  Yes it really has spread as far as linux/list.h and
> linux/kdev_t.h !

Good to see you follow up on that. The (by far) more important thing is
dm for 2.5 -- where is it?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283805AbRLEIhR>; Wed, 5 Dec 2001 03:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283804AbRLEIhI>; Wed, 5 Dec 2001 03:37:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9994 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283801AbRLEIgr>;
	Wed, 5 Dec 2001 03:36:47 -0500
Date: Wed, 5 Dec 2001 09:36:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] BUG_ON() not arch-specific.
Message-ID: <20011205093610.K15152@suse.de>
In-Reply-To: <E16BWQ4-00070r-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BWQ4-00070r-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05 2001, Rusty Russell wrote:
> Hi all,
> 
> 	We only need one BUG_ON implementation, surely.  Genericized
> and moved to linux/kernel.h.

Yes, fine.

-- 
Jens Axboe


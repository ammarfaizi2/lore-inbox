Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSJPCN4>; Tue, 15 Oct 2002 22:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSJPCN4>; Tue, 15 Oct 2002 22:13:56 -0400
Received: from dp.samba.org ([66.70.73.150]:48620 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264745AbSJPCNx>;
	Tue, 15 Oct 2002 22:13:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: mingo@redhat.com, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] gfp_t 
In-reply-to: Your message of "Thu, 26 Sep 2002 23:15:05 +0200."
             <20020926211505.GE1892@jaquet.dk> 
Date: Wed, 16 Oct 2002 09:10:17 +1000
Message-Id: <20021016021949.B5A992C0CF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020926211505.GE1892@jaquet.dk> you write:
> > After having had a bit more caffeine, I guess I would like to
> > change my previous mail to: These two patches for mm/numa.c and
> > ntfs/malloc.h needs to be in your patchset as well.
> 
> Another one:

Thanks, both added.  The patch is unlikely to go anywhere unless
someone champions it though.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

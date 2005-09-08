Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVIHAlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVIHAlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVIHAlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:41:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932438AbVIHAlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:41:09 -0400
Date: Wed, 7 Sep 2005 17:41:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
In-Reply-To: <Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
References: <1126053452.5012.28.camel@mulgrave> <Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Sep 2005, Linus Torvalds wrote:
>
> You meant 
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git
> 
> I do believe,

And also, this fails to compile due to the klist problem.

Quite frankly, what's the point in asking people to pull a tree that is 
known to not compile?

Now I made the mistake of pushing the thing out before I realized that the 
thing that you asked me to pull was the same thing that was known to be 
incomplete and non-working. That just makes me irritated.

		Linus

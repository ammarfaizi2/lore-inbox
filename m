Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVIHAyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVIHAyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIHAyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:54:00 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:23698 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932495AbVIHAx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:53:59 -0400
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
References: <1126053452.5012.28.camel@mulgrave>
	 <Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
	 <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 19:53:50 -0500
Message-Id: <1126140830.4823.61.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 17:41 -0700, Linus Torvalds wrote:
> And also, this fails to compile due to the klist problem.
> 
> Quite frankly, what's the point in asking people to pull a tree that is 
> known to not compile?
> 
> Now I made the mistake of pushing the thing out before I realized that the 
> thing that you asked me to pull was the same thing that was known to be 
> incomplete and non-working. That just makes me irritated.

That would be why I told you the tree was still waiting for the klist
fix, and why I waited to request a pull until I saw Andrew send it to
you.

James



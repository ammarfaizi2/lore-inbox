Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTHHDBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 23:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271200AbTHHDBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 23:01:25 -0400
Received: from mayhem.byteworld.com ([63.127.169.21]:57244 "EHLO
	chaos.byteworld.com") by vger.kernel.org with ESMTP id S271197AbTHHDBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 23:01:24 -0400
Date: Thu, 7 Aug 2003 23:01:33 -0400
From: William Enck <wenck@wapu.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [bk patches] 2.6.x net driver updates
Message-ID: <20030808030133.GA20401@chaos.byteworld.com>
References: <20030808000508.GA4464@gtf.org> <20030808013649.GA20003@chaos.byteworld.com> <3F32FFAD.1050203@pobox.com> <20030808020416.GA20116@chaos.byteworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808020416.GA20116@chaos.byteworld.com>
User-Agent: Mutt/1.3.28i
X-Sent-From: chaos.byteworld.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 10:04:16PM -0400, William Enck wrote:
> The first set i was from -test2-bk7 and the second was from your patch.
> Your patch didn't cause the problem. I replied to your email because you
> had updates to orinoco_cs.c and I thought there was a chance your patch
> was supposed to fix it. I guess a reply was not the best thing to do,
> shall I start a new thread?

This looks like it is a totaly separate problem. I tested -mm5 and it
didn't work in there either. I'm going to start a new thread for this.

Will

-- 
William Enck
wenck@wapu.org

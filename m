Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTBPMSu>; Sun, 16 Feb 2003 07:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTBPMSu>; Sun, 16 Feb 2003 07:18:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:62413 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266443AbTBPMSt>;
	Sun, 16 Feb 2003 07:18:49 -0500
Date: Sun, 16 Feb 2003 04:29:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: anton@samba.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] elv_former_request reversion
Message-Id: <20030216042926.627210db.akpm@digeo.com>
In-Reply-To: <20030216115908.GY26738@suse.de>
References: <20030215161236.67ce3f24.akpm@digeo.com>
	<20030216093244.GP26738@suse.de>
	<20030216115908.GY26738@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 12:28:40.0119 (UTC) FILETIME=[EFA5F470:01C2D5B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Andrew, does this work for you?

Yes.  I threw a bunch of nastiness at that on IDE and SCSI, 2-way and 4-way. 
No problems.  Thanks.


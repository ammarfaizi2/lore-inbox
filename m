Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbREYVCf>; Fri, 25 May 2001 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbREYVC0>; Fri, 25 May 2001 17:02:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62728 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261881AbREYVCL>;
	Fri, 25 May 2001 17:02:11 -0400
Date: Fri, 25 May 2001 23:02:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check kmalloc return in ide-cd.c (244-ac16)
Message-ID: <20010525230210.A22714@suse.de>
In-Reply-To: <20010525213422.B851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010525213422.B851@jaquet.dk>; from rasmus@jaquet.dk on Fri, May 25, 2001 at 09:34:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2001, Rasmus Andersen wrote:
> Hi.
> 
> This patch adds a check for the return value from kmalloc in
> ide_cdrom_open. Applies against ac16.

Thanks, applied.

-- 
Jens Axboe


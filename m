Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbREQVcg>; Thu, 17 May 2001 17:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbREQVc0>; Thu, 17 May 2001 17:32:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19973 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262186AbREQVcL>;
	Thu, 17 May 2001 17:32:11 -0400
Date: Thu, 17 May 2001 23:31:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: ATA overlap/queuing support ?
Message-ID: <20010517233134.D3227@suse.de>
In-Reply-To: <3B043FA1.D45D3B2B@linux-ide.org> <Pine.LNX.4.10.10105171417550.2341-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10105171417550.2341-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, May 17, 2001 at 02:22:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17 2001, Andre Hedrick wrote:
> ATA-overlap or ATAPI-overlap?  The later is known as DSC based on
> SFF-8020/8070/8090, I have forgotten where it is located but I have the
> docs, and it is supported in ide-floppy and ide-tape.

And ide-cd

-- 
Jens Axboe


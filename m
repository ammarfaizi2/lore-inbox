Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUFHJMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUFHJMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUFHJMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:12:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37538 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264910AbUFHJMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:12:19 -0400
Date: Tue, 8 Jun 2004 11:12:11 +0200
From: Jens Axboe <axboe@suse.de>
To: THroLL <makiaveli@SoftHome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I get hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error } with a 80GB Maxtor drive
Message-ID: <20040608091208.GQ13836@suse.de>
References: <1086667443.847.9.camel@Tupac.wesTsiDe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086667443.847.9.camel@Tupac.wesTsiDe.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08 2004, THroLL wrote:
> Hello
> 	I've just buy a new ata 133 disk and when I try to partition it or
> mount any partition from it I get the same error lines:
> 
> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }
> hdb: Write Cache FAILED Flushing!

Ignore it, it isn't fatal in any way. Or upgrade to 2.6.7-rc3.

-- 
Jens Axboe


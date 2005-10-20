Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbVJTLZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVJTLZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJTLZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 07:25:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751487AbVJTLZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 07:25:49 -0400
Date: Thu, 20 Oct 2005 13:26:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 03/05] blk: move last_merge handling into generic elevator code
Message-ID: <20051020112638.GD2811@suse.de>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.2FBB370A@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019123429.2FBB370A@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19 2005, Tejun Heo wrote:
> 03_blk_generic-last_merge-handling.patch
> 
> 	Currently, both generic elevator code and specific ioscheds
>         participate in the management and usage of last_merge.  This
>         and the following patches move last_merge handling into
>         generic elevator code.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Applied

-- 
Jens Axboe


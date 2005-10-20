Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVJTLZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVJTLZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 07:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVJTLZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 07:25:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13351 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751489AbVJTLZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 07:25:56 -0400
Date: Thu, 20 Oct 2005 13:26:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 04/05] blk: remove last_merge handling from ioscheds
Message-ID: <20051020112646.GE2811@suse.de>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.3444D769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019123429.3444D769@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19 2005, Tejun Heo wrote:
> 04_blk_generic-last_merge-handling-update-for-ioscheds.patch
> 
> 	Remove last_merge handling from all ioscheds.  This patch
> 	removes merging capability of noop iosched.

Applied

-- 
Jens Axboe


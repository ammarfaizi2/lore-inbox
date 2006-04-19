Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWDSIOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWDSIOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWDSIOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:14:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750742AbWDSIOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:14:34 -0400
Date: Wed, 19 Apr 2006 10:15:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Coywolf Qi Hunt <qiyong@freeforge.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] cleanup: use blk_queue_stopped
Message-ID: <20060419081506.GC4353@suse.de>
References: <20060419032702.GA6369@everest.sosdg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419032702.GA6369@everest.sosdg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18 2006, Coywolf Qi Hunt wrote:
> Hi,
> 
> This cleanup the source to use blk_queue_stopped.

Thanks, applied.

-- 
Jens Axboe


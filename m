Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUKNN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUKNN6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUKNN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:58:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261306AbUKNN6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:58:17 -0500
Date: Sun, 14 Nov 2004 14:58:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mark as_init and as_exit as init and exit functions
Message-ID: <20041114135800.GA19525@suse.de>
References: <20041112141556.S14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112141556.S14339@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12 2004, Chris Wright wrote:
> Mark as_init and as_exit as init and exit functions, and make them static.

Thanks (for all 3). This is an oversight from the recent modularization
of the io schedulers.

-- 
Jens Axboe


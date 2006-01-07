Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWAGOc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWAGOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbWAGOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:32:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46964 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1752265AbWAGOc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:32:59 -0500
Date: Sat, 7 Jan 2006 15:34:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark v Wolher <trilight@ns666.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20060107143447.GF3389@suse.de>
References: <43BFC3FF.5080908@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BFC3FF.5080908@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Mark v Wolher wrote:
> Hiya all,
> 
> I was just playing a cd as usual and i noticed suddenly the errors
> below, they repeated like 8 times.
> 
> kernel: 2.6.14.5

Should be fixed in newer 2.6.14.x, and in 2.6.15.

-- 
Jens Axboe


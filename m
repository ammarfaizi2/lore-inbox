Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWCXIxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWCXIxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWCXIxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:53:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59198 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932575AbWCXIxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:53:40 -0500
Date: Fri, 24 Mar 2006 09:53:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] unused label in drivers/block/cciss.c
Message-ID: <20060324085346.GE9753@suse.de>
References: <1143140501.17843.9.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143140501.17843.9.camel@alice>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2006, Eric Sesterhenn wrote:
> hi,
> 
> this patch removes a warning about an unused label, by
> moving the label into the ifdef.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Thanks, applied to for-linus upstream branch.

-- 
Jens Axboe


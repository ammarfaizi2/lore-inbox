Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUCKJQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUCKJQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:16:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262915AbUCKJQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:16:11 -0500
Date: Thu, 11 Mar 2004 10:16:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311091607.GI6955@suse.de>
References: <20040310124507.GU4949@suse.de> <20040311091430.GB2138@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311091430.GB2138@reti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2004, Joe Thornber wrote:
> Jens,
> 
> Small locking changes to the dm bits.  I've just seen that you've
> posted an updated version of your patch to lkml, so I'll post another
> version of this patch to that thread too.

Thanks Joe, you don't have to generate a new diff, I'll just adapt this
version and post an update.

-- 
Jens Axboe


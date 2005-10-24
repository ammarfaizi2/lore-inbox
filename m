Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVJXMWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVJXMWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVJXMWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:22:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750971AbVJXMWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:22:22 -0400
Date: Mon, 24 Oct 2005 14:23:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051024122310.GN2811@suse.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24 2005, Andrew Morton wrote:
> - Added git-blktrace.patch to the -mm lineup: Jens's block-layer tracing
>   infrastructure.   It appears to be undocumented...

If 20 pages of pdf documentation is undocumented, then we've raised the
bar a lot when it comes to documentation :-)

If you pull the blktrace tools, there's a README in there and if you
do a make docs it will generate a users manual for you.

I will update the in-kernel documentation, it does need a little work in
the Kconfig section. And I'll add a pointer to the user tool repo which
has a lot more info.

-- 
Jens Axboe


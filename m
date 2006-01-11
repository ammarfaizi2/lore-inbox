Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWAKKEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWAKKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWAKKEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:04:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25952 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751437AbWAKKEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:04:07 -0500
Date: Wed, 11 Jan 2006 11:06:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2G memory split
Message-ID: <20060111100601.GX3389@suse.de>
References: <20060110202819.GJ3389@suse.de> <E1EwbWM-00029C-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EwbWM-00029C-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Bernd Eckenfels wrote:
> Jens Axboe <axboe@suse.de> wrote:
> > To me the former is clearer, it tells you that you have one full gig of
> > low memory. But maybe that's just me.
> 
> It still does not describe what the consequences, especiall the difference
> to the non-optimized case is. When do you want to use it, and when not.

Please, I told you before in this thread, don't drop people from the cc
list!

But it does explain that, it says full 1g low memory support. So you
have one full gig of low memory, compared to the default setting.
Describing this in painstakingly more detail it of course possible, but
as the help text mentions, if you are not sure then you better leave
this option at its default setting.

-- 
Jens Axboe


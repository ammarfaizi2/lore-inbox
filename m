Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHMR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHMR0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:26:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47809 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266281AbUHMR0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:26:12 -0400
Date: Fri, 13 Aug 2004 19:26:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Stefan Meyknecht <sm0407@nurfuerspam.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Message-ID: <20040813172605.GA9673@suse.de>
References: <200408061833.30751.sm0407@nurfuerspam.de> <200408071412.17411.sm0407@nurfuerspam.de> <20040809063323.GB10418@suse.de> <200408131917.48833.sm0407@nurfuerspam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131917.48833.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Stefan Meyknecht wrote:
> Hi,
> 
> Jens Axboe <axboe@suse.de> wrote:
> > Patch looks fine (last hunk is a little code, but that's not your
> > fault). Thanks!
> 
> Do you consider including the patch into 2.6.8 or is it too late? 
> Please mail me if something is missing or to resend.

IMHO it's fine for 2.6.8, please resend the patch and CC Linus.

-- 
Jens Axboe


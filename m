Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVCIVMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVCIVMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCIVLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:11:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3023 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262473AbVCIVJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:09:36 -0500
Date: Wed, 9 Mar 2005 22:09:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050309210926.GZ28855@suse.de>
References: <9e47339105030909031486744f@mail.gmail.com> <422F2F7C.3010605@pobox.com> <9e4733910503091023474eb377@mail.gmail.com> <422F5D0E.7020004@pobox.com> <9e473391050309125118f2e979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050309125118f2e979@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09 2005, Jon Smirl wrote:
> On Wed, 09 Mar 2005 15:31:10 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Well, there are no changes in libata from bk4 to present.  The only
> > thing I see in the -bk4-bk5 increment diff that's immediately noticeable
> > is the barrier stuff.
> 
> bk4 works
> bk5 is broken
> 
> Where are these *.key files? Maybe I can do some more divide and
> conquer in bitkeeper.

probably not worth the bother, looks like barrier problems. get the
serial console running instead and send the full output, I'll take a
look in the morning.

-- 
Jens Axboe


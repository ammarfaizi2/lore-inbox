Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCFKNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCFKNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCFKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:13:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261348AbVCFKNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:13:22 -0500
Date: Sun, 6 Mar 2005 11:13:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Vincent Vanackere <vincent.vanackere@gmail.com>, kernel@kolivas.org,
       ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-ck1 (cfq-timeslice)
Message-ID: <20050306101306.GF18335@suse.de>
References: <200503030030.29722.kernel@kolivas.org> <65258a58050304064710b403d7@mail.gmail.com> <20050304140750.757e9f4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304140750.757e9f4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Andrew Morton wrote:
> Vincent Vanackere <vincent.vanackere@gmail.com> wrote:
> >
> > Speaking of the cfq-timeslice scheduler, is there a version that
> > applies to recent -mm kernels ?
> 
> Yes, what happened to that?

Don't exactly remember :-)

I'll post an updated version for -mm, I'd like for it to spend a
cycle there.

-- 
Jens Axboe


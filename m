Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263350AbVCKPUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbVCKPUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbVCKPUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:20:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17607 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263350AbVCKPSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:18:06 -0500
Date: Fri, 11 Mar 2005 16:17:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Vincent Vanackere <vincent.vanackere@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-ck1 (cfq-timeslice)
Message-ID: <20050311151758.GK28188@suse.de>
References: <200503030030.29722.kernel@kolivas.org> <65258a58050304064710b403d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65258a58050304064710b403d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Vincent Vanackere wrote:
> > Added since 2.6.10-ck7:
> > +cfq-ts-21.diff
> > The latest version of Jens' cfq-timeslice i/o scheduler now heavily tested and
> > with full read i/o priority support
> 
> Speaking of the cfq-timeslice scheduler, is there a version that
> applies to recent -mm kernels ?

It will be in the next -mm kernel.

-- 
Jens Axboe


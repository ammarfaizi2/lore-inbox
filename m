Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbULHG4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbULHG4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbULHG4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:56:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33179 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262003AbULHG4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:56:45 -0500
Date: Wed, 8 Dec 2004 07:55:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208065551.GG3035@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041207180844.0fa92601.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207180844.0fa92601.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > If a distro is
> >  always selecting CFQ then they've probably gone and deoptimised all their
> >  IDE users.  
> 
> That being said, yeah, once we get the time-sliced-CFQ happening, it should
> probably be made the default, at least until AS gets fixed up.  We need to
> run the numbers and settle on that.

I'll do a new round of numbers today.

-- 
Jens Axboe


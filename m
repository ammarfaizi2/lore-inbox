Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263114AbTCLI7E>; Wed, 12 Mar 2003 03:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbTCLI7E>; Wed, 12 Mar 2003 03:59:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263114AbTCLI7C>;
	Wed, 12 Mar 2003 03:59:02 -0500
Date: Wed, 12 Mar 2003 10:09:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312090943.GA3298@suse.de>
References: <20030312085145.GJ811@suse.de> <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Andre Hedrick wrote:
> 
> So lets dirty list the one drive by Paul G. and be done.
> Can we do that?

Who cares, really? There's not much point in doing it, we're talking 248
vs 256 sectors in reality. I think it's a _bad_ idea, lets just keep it
at 255 and avoid silly drive bugs there.

-- 
Jens Axboe


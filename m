Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311292AbSCLRDI>; Tue, 12 Mar 2002 12:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311295AbSCLRDC>; Tue, 12 Mar 2002 12:03:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311294AbSCLRCt>;
	Tue, 12 Mar 2002 12:02:49 -0500
Date: Tue, 12 Mar 2002 14:17:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Karsten Weiss <knweiss@gmx.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312131751.GC1473@suse.de>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva> <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12 2002, Karsten Weiss wrote:
> CONFIG_BLK_DEV_ELEVATOR_NOOP

This really ought to get killed in the 2.4 branch, btw, I'm surprised
it's still there. It's completely bogus.

-- 
Jens Axboe


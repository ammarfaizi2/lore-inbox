Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287786AbSAFKSG>; Sun, 6 Jan 2002 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287790AbSAFKR4>; Sun, 6 Jan 2002 05:17:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287786AbSAFKRo>;
	Sun, 6 Jan 2002 05:17:44 -0500
Date: Sun, 6 Jan 2002 11:17:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Alistair Riddell <ali@gwc.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no highmem with 2GB RAM?
Message-ID: <20020106111737.C8673@suse.de>
In-Reply-To: <Pine.LNX.4.21.0201050126410.12917-100000@frank.gwc.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201050126410.12917-100000@frank.gwc.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05 2002, Alistair Riddell wrote:
> I have a couple of SMP i386 boxes with 2GB RAM. They suffer from poor
> performance due to block IO page bouncing with highmem enabled. I have
> tried the block-highmem patch but this causes occasional oopses and even
> panics under high IO load.

Well thanks for sending in a bug report on that. Mind doing so?

-- 
Jens Axboe


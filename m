Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289773AbSAKHAP>; Fri, 11 Jan 2002 02:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289830AbSAKHAJ>; Fri, 11 Jan 2002 02:00:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48646 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289773AbSAKG7z>;
	Fri, 11 Jan 2002 01:59:55 -0500
Date: Fri, 11 Jan 2002 07:59:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike <m.mohr@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.[0&1]
Message-ID: <20020111075951.O19814@suse.de>
In-Reply-To: <3C3E8D2A.66C96E37@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3E8D2A.66C96E37@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10 2002, Mike wrote:
> Good evening everyone.
> 
> I'm new to this list.  After using Linux off and on for about 1 year, I
> have learned just enough to get around and do very basic system
> maintenance.  I am at the point where I need to recompile my kernel.  I
> have done so successfully with the source-code included in my dist
> (Slackware 8 currently), but am having problems with the most current
> kernels.
> 
> Kernel sources decompressed without error and compiled just as expected,
> no errors.  Total bzImage size was about 920kb.  After using LILO to
> install kernel 2.5.0 and rebooting, my computer shows the Loading
> Linux............ text, then very briefly shows OK, Uncompressing
> Linux..., but immediately reboots the system before it can initialize.

Did you choose the right CPU type?

-- 
Jens Axboe


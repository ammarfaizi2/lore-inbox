Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSL3OQG>; Mon, 30 Dec 2002 09:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbSL3OQG>; Mon, 30 Dec 2002 09:16:06 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:11 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266971AbSL3OQG>; Mon, 30 Dec 2002 09:16:06 -0500
Date: Mon, 30 Dec 2002 14:24:58 +0000
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] remove __MOD_* from dm
Message-ID: <20021230142458.GD2703@reti>
References: <20021220233855.GA13962@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220233855.GA13962@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 03:38:56PM -0800, Greg KH wrote:
> Here's another patch against 2.5.52-bk that gets rid of the old __MOD_*
> functions for the newer module api.  This also allows the modules to be
> unloaded.
> 
> Joe, please add this to your next round of patches.

Thanks Greg, if the following patchset has no problems I'll push it to
Linus at the end of the week.

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.53/2.5.53-dm-2.tar.bz2

- Joe

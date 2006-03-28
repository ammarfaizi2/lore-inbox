Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWC1IBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWC1IBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWC1IBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:01:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17122
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751188AbWC1IBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:01:40 -0500
Date: Tue, 28 Mar 2006 00:01:14 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.1
Message-ID: <20060328080114.GC8097@kroah.com>
References: <20060328075629.GA8083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328075629.GA8083@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 11:56:29PM -0800, Greg KH wrote:
> We (the -stable team) are announcing the release of the 2.6.16.1 kernel.
> 
> The diffstat and short summary of the fixes are below.
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.16 and 2.6.16.1, as it is small enough to do so.
> 
> The updated 2.6.16.y git tree can be found at:
>  	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git

Oops, that should be:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

sorry about that...

Hm, we shouldn't be using "rsync" as part of a git url these days.
What's the recommended way of writing kernel.org git tree addresses now?

thanks,

greg k-h

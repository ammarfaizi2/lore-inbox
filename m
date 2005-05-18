Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVERWuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVERWuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVERWui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:50:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:27343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262326AbVERWrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:47:09 -0400
Date: Wed, 18 May 2005 15:53:02 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.12-rc4
Message-ID: <20050518225302.GA21748@kroah.com>
References: <20050517221136.GA29232@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517221136.GA29232@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 03:11:36PM -0700, Greg KH wrote:
> Here are 2 patches for the 2.6.12-rc4 tree that clean up some driver
> core stuff.  Both of these patches have been in the -mm tree for a
> while.
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> 
> Full patches will be sent to the linux-kernel mailing list, if anyone
> wants to see them.

Oh crap, I updated the rsync tree, but never did the HEAD file, sorry
about that.  I'll not use the --ignore-existing flag to rsync again...

So, could you please pull from this repo again?

thanks,

greg k-h

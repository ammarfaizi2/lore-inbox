Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDOQUb (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTDOQUb 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:20:31 -0400
Received: from granite.he.net ([216.218.226.66]:47366 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261804AbTDOQU3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:20:29 -0400
Date: Tue, 15 Apr 2003 09:33:14 -0700
From: Greg KH <greg@kroah.com>
To: sean darcy <seandarcy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-bk4 & 5  - boot oops at  USB Mass Storage
Message-ID: <20030415163314.GA12105@kroah.com>
References: <F102ZBNCogiwHsqhA5300000785@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F102ZBNCogiwHsqhA5300000785@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 08:42:53AM -0400, sean darcy wrote:
> 2.5.67 boots fine. With bk4 or bk5 I get an oops right after:
> 
> USB Mass Storage support registered
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000040
> printing EIP:
> c026af44
> *pde=00000000
> oops: 0002 [#1]
> cpu: 0
> EIP: 0060:[c026af44] Not tainted

Ah, so close, can you please report back everything that the oops
message said?

thanks,

greg k-h

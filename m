Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbUKCV4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUKCV4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUKCVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:53:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:6536 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261919AbUKCVvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:51:41 -0500
Date: Wed, 3 Nov 2004 13:51:30 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Type-checking for pci layer
Message-ID: <20041103215130.GA30621@kroah.com>
References: <20041103214711.GA1885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103214711.GA1885@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 10:47:11PM +0100, Pavel Machek wrote:
> Hi!
> 
> This adds type-checking to PCI layer. u32 has been replaced with
> defines, so it is no longer easy to confuse it with system suspend
> level. Patrick included it in his power tree, but I guess direct
> merging to you (Andrew) is faster/easier way to go? Please apply,
> 
> 								Pavel
> 
> Acked-by: Greg KH <greg@kroah.com>

Woah, I've never acked this patch.  Let me push it through my pci trees,
or if Pat's already taken it, I'll get it from him through that path.

thanks,

greg k-h

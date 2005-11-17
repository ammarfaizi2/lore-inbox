Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbVKQBPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbVKQBPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbVKQBPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:15:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:7648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161067AbVKQBPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:15:20 -0500
Date: Wed, 16 Nov 2005 16:55:12 -0800
From: Greg KH <gregkh@suse.de>
To: David Kubicek <dave@awk.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: USB patches for 2.6.15-rc1??
Message-ID: <20051117005512.GB15140@suse.de>
References: <20051114200456.GA2319@kroah.com> <20051114200924.GA2531@kroah.com> <20051115084801.GA13387@awk.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115084801.GA13387@awk.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 09:48:01AM +0100, David Kubicek wrote:
> may I ask you what about the "URB/buffer ring queue" patch I've
> submitted months ago for CDC ACM modems and which you accepted into your
> tree when Oliver sent it to you for merging like a week ago?

It's only been in my tree for a week.  It came to me after I had done
the big merge cycle with Linus after 2.6.14 came out.  For major changes
to a driver like this one, I want to get some good testing in the -mm
tree, and then it will go into mainline.

So, it will be a few more weeks, I'll send it to Linus after 2.6.15 is
out.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbWI0FLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWI0FLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWI0FLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:11:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:59275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965330AbWI0FLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:11:13 -0400
Date: Tue, 26 Sep 2006 22:02:19 -0700
From: Greg KH <greg@kroah.com>
To: James <iphitus@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       oliver@neukum.name
Subject: Re: PROBLEM: Nokia 6280 + provided USB cable throws BUG's and hardlocks.
Message-ID: <20060927050219.GD32644@kroah.com>
References: <1e1a7e1b0609260045l41161c2bp5b520efb68d97fce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1a7e1b0609260045l41161c2bp5b520efb68d97fce@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 05:45:26PM +1000, James wrote:
> Hey
> 
> Attempting to connect and use my Nokia 6280 with the supplied Nokia
> USB cable (reads: 'Type: CA-53') causes the kernel to through BUG's,
> and has on occasion caused a complete lock up of the system.
> 
> This is running 2.6.18, and also occurs on the 2.6.17 series, which
> was what I was using when I received the phone. I have no idea about
> kernels before.

See:
	http://bugzilla.kernel.org/show_bug.cgi?id=7201

others are having the same issue.

thanks,

greg k-h

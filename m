Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUDVXn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDVXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 19:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUDVXn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 19:43:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:38872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262837AbUDVXn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 19:43:57 -0400
Date: Thu, 22 Apr 2004 16:30:45 -0700
From: Greg KH <greg@kroah.com>
To: Andrew D Kirch <trelane@trelane.net>
Cc: evolution@lists.ximian.com, linux-kernel@vger.kernel.org
Subject: Re: sync'ing evolution with 2.6/udev
Message-ID: <20040422233045.GA4003@kroah.com>
References: <1082668904.16612.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082668904.16612.8.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 04:21:44PM -0500, Andrew D Kirch wrote:
> This is a bit of an odd cross post, but please stick with me if you
> will...
> 
> I am attempting to add a USB cradle (Visor Prism if anyone cares) with
> Evolution.  /var/log/messages gives me the following output:
> 
> Apr 22 16:01:36 localhost kernel: usb 2-2: new full speed USB device
> using address 10
> Apr 22 16:01:37 localhost usb.agent[29165]: ... no modules for USB
> product 82d/100/100

Have you tried the visor driver?  It should work for you.

thanks,

greg k-h

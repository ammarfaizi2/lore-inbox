Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUHNFwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUHNFwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 01:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUHNFwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 01:52:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:34714 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265993AbUHNFv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 01:51:56 -0400
Date: Fri, 13 Aug 2004 22:50:58 -0700
From: Greg KH <greg@kroah.com>
To: Andy Stewart <andystewart@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB kernel oops 2.6.7
Message-ID: <20040814055057.GE6838@kroah.com>
References: <200408131947.55873.andystewart@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131947.55873.andystewart@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 07:47:45PM -0400, Andy Stewart wrote:
> 
> HI everybody,
> 
> When I unplugged my Kodak DC4800 USB camera, I noticed this kernel problem 
> in /var/log/messages.  I'm running a stock 2.6.7 kernel compiled for SMP.  

Can you try 2.6.8-rc4 to see if this is fixed there or not?

And did you unmount the camera after mounting it, before removing the
device?

thanks,

greg k-h

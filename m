Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269618AbTGJVUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTGJVUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:20:11 -0400
Received: from storm.he.net ([64.71.150.66]:8669 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269618AbTGJVUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:20:07 -0400
Date: Thu, 10 Jul 2003 13:48:11 -0700
From: Greg KH <greg@kroah.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: CRIS architecture update
Message-ID: <20030710204811.GB13089@kroah.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB03277AA5@mailse01.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB03277AA5@mailse01.axis.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 10:24:56PM +0200, Mikael Starvik wrote:
> >Speaking of older kernels, any chances for a 2.5 update? 
> 
> Yes. I have sent patches to Linus several times, the latest one today.
> So far he has been dropping my patches on the floor.
> 
> So far our 2.5 tree doesn't have a USB driver because I 
> would like to wait until the USB framework is less volatile.

Heh, like that will ever happen... :)

But any api changes that are made to USB are also made to all in-kernel
drivers.  I've been skipping the CRIS USB driver since way back in early
2.5 you told me too.

> In my mind we will port the USB driver somewhere around
> 2.6.0.

Glad to hear it.

thanks,

greg k-h

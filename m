Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVKQXzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVKQXzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVKQXzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:55:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:32696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965141AbVKQXzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:55:24 -0500
Date: Thu, 17 Nov 2005 15:36:11 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Small fixups to driver core
Message-ID: <20051117233611.GA10348@kroah.com>
References: <Pine.LNX.4.44L0.0511171444400.4452-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511171444400.4452-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 03:04:42PM -0500, Alan Stern wrote:
> 
> Greg, you originally write driver_bind and driver_unbind.  Shame on you
> for messing up the refcounting!  :-)

Bleah, thanks for catching this, I've queued it to my tree.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFBV0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFBV0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFBVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:24:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:56199 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261306AbVFBVOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:14:19 -0400
Date: Thu, 2 Jun 2005 12:37:16 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support multiply-LUN devices in ub
Message-ID: <20050602193715.GA1860@kroah.com>
References: <20050501160540.5b2f4e61.zaitcev@redhat.com> <20050502230452.GA5186@kroah.com> <20050602095651.351eca48.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602095651.351eca48.zaitcev@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 09:56:51AM -0700, Pete Zaitcev wrote:
> On Mon, 2 May 2005 16:04:52 -0700, Greg KH <greg@kroah.com> wrote:
> > On Sun, May 01, 2005 at 04:05:40PM -0700, Pete Zaitcev wrote:
> > > Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> > 
> > Applied, thanks.
> 
> This is not present in 2.6.12-rc5-git7, but other USB fixes are.
> Did you drop it?

Nope, it's in my stack of usb patches at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/

It's showing up in the -mm tree, right?  I held off sending this to
Linus as I thought it didn't fit into the "bugfix" only type of patch
that we should be sending so late in the -rc series.  Granted the -rc
series is taking forever...

So, do you want me to push it to him now?  It's your choice.

thanks,

greg k-h

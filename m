Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVAHWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVAHWhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAHWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:34:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:10693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262032AbVAHW3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:29:55 -0500
Date: Sat, 8 Jan 2005 14:28:47 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] I2C patches for 2.6.10
Message-ID: <20050108222845.GA3415@kroah.com>
References: <20050108053849.GA8065@kroah.com> <20050108190943.GA31973@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108190943.GA31973@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 07:09:43PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 07, 2005 at 09:38:49PM -0800, Greg KH wrote:
> > Hi,
> > 
> > Here are some i2c driver fixes and updates for 2.6.10.  There are a few
> > new i2c drivers in here, and a number of bugfixes.  Almost all of these
> > patches have been in the past few -mm releases.
> > 
> > Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6
> > 
> > Individual patches will follow, sent to the sensors and linux-kernel
> > lists.
> 
> Could you please put a slightly more usefull subject line into your mails.
> Three gazillion times the same subject absolutely does not help review.

Hm, yeah, I'll work on my scripts to try to do this in the future.  It
would be a good idea.

thanks,

greg k-h

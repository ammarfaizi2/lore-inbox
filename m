Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbVJGWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbVJGWEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVJGWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:04:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:34217 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030552AbVJGWEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:04:42 -0400
Date: Fri, 7 Oct 2005 15:04:23 -0700
From: Greg KH <greg@kroah.com>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFClue] pci_get_device, new driver model
Message-ID: <20051007220423.GA19232@kroah.com>
References: <43469FB8.50303@beezmo.com> <20051007214504.GA11545@kroah.com> <20051007220325.GA18638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007220325.GA18638@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 03:03:25PM -0700, Greg KH wrote:
> On Fri, Oct 07, 2005 at 02:45:04PM -0700, Greg KH wrote:
> > > If I just give in to the new driver model how/when do I associate
> > > instance/minor numbers with boards found?
> 
> Oh, and if you don't convert to the new driver model,

And it's not "new" at all, it's been there since 2.3 days, so it's not
like you haven't had enough warning...

thanks,

greg k-h

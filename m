Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUI2X3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUI2X3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUI2X3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:29:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:6350 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269198AbUI2X2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:28:07 -0400
Date: Wed, 29 Sep 2004 16:27:48 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: hotplug <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NULL arg for get_device() / put_device()
Message-ID: <20040929232748.GD26548@kroah.com>
References: <415805DD.4040708@suse.de> <20040928012801.GA11125@kroah.com> <41590CB9.8060405@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41590CB9.8060405@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:03:21AM +0200, Hannes Reinecke wrote:
> Greg KH wrote:
> >On Mon, Sep 27, 2004 at 02:21:49PM +0200, Hannes Reinecke wrote:
> >
> >>Hi all,
> >>
> >>is there a specific reason that get_device accepts NULL as argument,
> >>whereas put_device() does not?
> >
> >
> >Um, I guess I never thought about it :)
> >
> >I don't see why it wouldn't take it, feel free to send a patch.
> >
> Here it is. Please apply.

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbTFLWqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbTFLWqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:46:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60382 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265040AbTFLWqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:46:46 -0400
Date: Thu, 12 Jun 2003 16:02:47 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612230246.GA1782@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com> <20030612155148.60a39787.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612155148.60a39787.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:51:48PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > <handwaving>
> 
> heh.
> 
> Thought about adding a sequence number to the /sbin/hotplug argument list?

/me owes you a lot of beer at ols.

That's a world simpler than my proposal, I think I'll go write that
patch right now...

thanks,

greg k-h

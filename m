Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUH0Uht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUH0Uht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUH0Ud5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:33:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:55483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267621AbUH0UcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:32:14 -0400
Date: Fri, 27 Aug 2004 13:31:07 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Summarizing the PWC driver questions/answers
Message-ID: <20040827203106.GA3546@kroah.com>
References: <20040827162613.GB32244@kroah.com> <Pine.LNX.4.44L0.0408271442040.650-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0408271442040.650-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 02:51:01PM -0400, Alan Stern wrote:
> On Fri, 27 Aug 2004, Greg KH wrote:
> 
> > Q: Why did you remove the hook from the pwc driver?
> > A: It was there for the explicit purpose to support a binary only
> >    module.  That goes against the kernel's documented procedures, so I
> >    had to take it out.
> 
> Can you say exactly where these procedures/policies are spelled out?

See Linus's response on this thread for a statement of such a policy.

As to where they are written down, I don't know, sorry.

greg k-h

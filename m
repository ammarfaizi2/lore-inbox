Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271001AbUJUVqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271001AbUJUVqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbUJUVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:46:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:63933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270836AbUJUVnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:43:13 -0400
Date: Thu, 21 Oct 2004 14:41:42 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Desktop kernel bk tree/patchset.
Message-ID: <20041021214142.GA14250@kroah.com>
References: <1098344977.4146.21.camel@desktop.cunninghams> <20041021161710.GA10561@kroah.com> <1098393829.4146.38.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098393829.4146.38.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 07:23:49AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-10-22 at 02:17, Greg KH wrote:
> > What USB patches do you have that are not in the mainline kernel
> > already?
> 
> None. I'm meaning pulling from your usb tree into it before changes get
> into Linus' tree, so improvements to PM support can get testing in the
> proposed tree as well.

Then why stop at USB?  Why not pci, i2c and driver core bk pulls too?
Continue down that path and you've duplicated the -mm tree :)

Good luck,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJHUik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJHUik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJHUik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:38:40 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:382 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264443AbUJHUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:38:10 -0400
Date: Fri, 8 Oct 2004 14:38:06 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
X-X-Sender: rminnich@linux.site
To: Greg KH <greg@kroah.com>
cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
In-Reply-To: <20041008202247.GA9653@kroah.com>
Message-ID: <Pine.LNX.4.58.0410081428230.9700@linux.site>
References: <20041008202247.GA9653@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.6.0.99824
X-PMX-Version: 4.6.0.99824
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Oct 2004, Greg KH wrote:

> 	If someone downloads the spec without joining the IBTA, and
> 	proceeds to use the spec for an implementation of the IBTA spec,
> 	that person (company) runs the risk of being a target of patent
> 	infringement claims by IBTA members.

Another solid reason to write infiniband off. I keep hoping that the IB 
vendor crowd will stop shooting themselves in the head with such 
regularity, and they just won't. They just keep increasing the size of the 
bore. 

Infiniband can now be spelled a few different ways, "I2O" and "ATM" come 
to mind, except that "ATM" was less unsuccessful in its lifetime than IB 
has been so far. 

> 	In justification for this position people say that they are just
> 	trying to get more people to join the IBTA because they need the
> 	dues, which by coincidence are $9500 per year, and point out
> 	that some other commonly used specs are similarly made available
> 	for steep prices. I don't know one way or the other about that
> 	but this sounds a lot like the reason that we all gave ourselves
> 	for NOT including SDP in the kernel[1].

> So, OpenIB group, how to you plan to address this issue?  Do you all
> have a position as to how you think your code base can be accepted into
> the main kernel tree given these recent events?

Well, we non-vendors have no power, and it appears the vendors are 
determined to kill IB. 

This is all very discouraging. A lot of people at the Labs put a lot of
work into the Infiniband openib effort, including getting money to support
the software development, and it looks like we're not going to get very
far if these rules stick. I am going to renew my search for non-IB
solutions, I guess. It's hard to recommend this interconnect when IBTA
takes this kind of action.


ron

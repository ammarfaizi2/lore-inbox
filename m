Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWHHJOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWHHJOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWHHJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:14:44 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:59268 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1750773AbWHHJOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:14:43 -0400
Date: Tue, 8 Aug 2006 10:14:40 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc strange hotplug/udev/uevent problem
Message-ID: <20060808101440.575d83ff@zeus.pccl.info>
In-Reply-To: <20060808060211.GA3206@kroah.com>
References: <44D79574.8080703@digital-domain.net>
	<20060808060211.GA3206@kroah.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 23:02:11 -0700, Greg KH wrote:

> On Mon, Aug 07, 2006 at 08:33:08PM +0100, Andrew Clayton wrote:
> > plug but not subsequent plugs.
> > 
> > If you rmmod the sd_mod module and plug in, then it will get
> > mounted.
> 
> That's just wierd.  I can't think of anything that has changed

Heh, yeah I thought so.

> recently to cause this.
> 
> Can you use 'git bisect' to try to narrow it down which change caused
> the problem?

Yeah, I'll start looking tonight.
 
> thansk,
> 
> greg k-h


Cheers,

Andrew

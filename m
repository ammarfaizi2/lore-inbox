Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUHJVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUHJVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267732AbUHJVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:07:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267708AbUHJVHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:07:22 -0400
Date: Tue, 10 Aug 2004 17:06:30 -0400
From: Alan Cox <alan@redhat.com>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Message-ID: <20040810210630.GA30906@devserv.devel.redhat.com>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408102148.57602.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408102148.57602.ianh@iahastie.local.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 09:48:57PM +0100, Ian Hastie wrote:
> What do those numbers refer to?  Card model numbers?  On ITE's site I can only 
> see an IT8212F which has RAID and an IT8211F that doesn't.

Product rather than chip numbers I think

> I got my IT8212F card from Novatech.  A generic card with no obviously 
> recognisable name and, IMO anyway, quite a reasonable price.  That is 
> assuming it really does everything that they say it can.

Thanks will investigate. I need to see what happens if I turn the 
firmware bits on with my card and then reboot the microprocessor - see if its
just bios crippled

> It certainly works quite well in pass through mode. *8)

But it has the raid mode stuff ?


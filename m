Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUHYQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUHYQzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUHYQzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:55:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:21208 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268122AbUHYQzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:55:37 -0400
Date: Wed, 25 Aug 2004 09:53:21 -0700
From: Greg KH <greg@kroah.com>
To: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-ID: <20040825165320.GB19556@kroah.com>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com> <20040719200608.280d17a1@lembas.zaitcev.lan> <1090344174.1388.471.camel@cog.beaverton.ibm.com> <20040720181700.GA2576@dmt.cyclades> <20040816113314.GD14159@logos.cnet> <1092678515.2429.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092678515.2429.4.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 10:48:36AM -0700, john stultz wrote:
> 
> Not yet. Greg K-H was going to push it to 2.6, but I think he's on
> vacation this week. 

Can you please just send me a clean 2.6 patch, with your changes already
in it (a forward port of the recent 2.4 patch would be most execelent,
as it also supports EHCI, which we need to do in 2.6 also.)

I'll be willing to apply that.

thanks,

greg k-h

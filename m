Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLCW0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLCW0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVLCW0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:26:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:63106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751298AbVLCW0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:26:52 -0500
Date: Sat, 3 Dec 2005 14:26:30 -0800
From: Greg KH <greg@kroah.com>
To: "M." <vo.sinh@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203222630.GA30230@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com> <20051203211209.GA4937@kroah.com> <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com> <1133645895.22170.33.camel@laptopd505.fenrus.org> <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 10:53:18PM +0100, M. wrote:
> from the kernel.org point of view it does make sense but from users
> pov i think no. Users stuck with old drivers not actively mantained
> would benefit from this.

Any specific examples of this?

> There are some open drivers wrote by hardware mantainers which will
> never get into kernel.org cause of code not following kernel style
> guides and so on. Yeah, you should not buy poorly supported hardware
> and use bad drivers but a lot of new users have poorly supported
> hardware and a "more stable than usual and at fixed dates" release
> could enlower the skills barrier in approaching linux.

The skills barrier has _nothing_ to do with the release cycles.

And if you want to get a driver into the main tree, that isn't being
maintained, just get a piece of the hardware to a kernel developer,
along with the driver and it will be maintained.  I know I've made that
offer many times in the past, and so has others.

thanks,

greg k-h

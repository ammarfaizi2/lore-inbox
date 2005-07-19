Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVGSU3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVGSU3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVGSU3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:29:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:29643 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261700AbVGSU3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:29:15 -0400
Date: Tue, 19 Jul 2005 16:29:01 -0400
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
Message-ID: <20050719202901.GA20439@kroah.com>
References: <42DD2EA4.5040507@opersys.com> <20050719192918.GA19803@kroah.com> <1121804216.4299.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121804216.4299.7.camel@mindpipe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 04:16:55PM -0400, Lee Revell wrote:
> On Tue, 2005-07-19 at 15:29 -0400, Greg KH wrote:
> > Ugh, you have a bad device or power supply, or aren't giving it enough
> > power to drive the thing.  Nothing we can do in Linux for that, sorry.
> > Buy a wall-powered usb hub, that usually helps.
> > 
> 
> I get the same messages on boot from a bus with no devices connected to
> it (hub 4).  I have not connected the motherboard header because I don't
> use that bus, could this be related?

Yes, it's probably just not grounded properly because the header is not
connected.  It's harmless and you can just ignore it.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTHaR35 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbTHaR35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:29:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:27340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262304AbTHaR34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:29:56 -0400
Date: Sun, 31 Aug 2003 10:30:07 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB not working correctly in 2.6.0-test4-mm4
Message-ID: <20030831173007.GB20548@kroah.com>
References: <20030831115903.GA2298@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831115903.GA2298@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 01:59:03PM +0200, Petr Baudis wrote:
>   Hello,
> 
>   I'm getting an oops when I try to connect my Zaurus (SL5500). When booting,
> hotplug brings up usb without problems:

Ouch, care to forward this to the linux-usb-devel mailing list, or
create a bug for it at bugzilla.kernel.org?

I have a bunch of usbnet patches pending to be sent to Linus later this
week, possibly those help this problem.  They were posted to the
linux-usb-devel list last week.

thanks,

greg k-h

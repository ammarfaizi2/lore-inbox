Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTHTAeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbTHTAeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:34:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:45771 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261608AbTHTAeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:34:03 -0400
Date: Tue, 19 Aug 2003 17:34:03 -0700
From: Greg KH <greg@kroah.com>
To: jjluza <jjluza@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
Message-ID: <20030820003403.GA13833@kroah.com>
References: <200308200206.20798.jjluza@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308200206.20798.jjluza@yahoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 02:06:20AM +0200, jjluza wrote:
> I try to make this modem working.
> It works very well on kernel 2.4 series.
> It work with some kernel 2.6 until test2-mm1.
> But since test2-mm1, the newer kernel doesn't work anymore.
> There is 2 related drivers for this modem.
> The one which is included in the kernel and which can be found here :
> http://www.linux-usb.org/SpeedTouch/
> and the one which I've always used until now :
> speedtouch.sourceforge.net
> 
> when I notice that the old one doesn't work anymore, I try with the driver 
> which included in the kernel, without success.

Take a look at a thread about this on the linux-usb-devel mailing list.
People are working on narrowing down the patch that caused this problem
and could probably use your help.

thanks,

greg k-h

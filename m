Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264779AbUEPSdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbUEPSdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEPSdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:33:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:52920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264779AbUEPSdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:33:43 -0400
Date: Sun, 16 May 2004 11:31:55 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
Message-ID: <20040516183155.GA17468@kroah.com>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <40A7AA0B.5000200@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A7AA0B.5000200@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 10:51:07AM -0700, David Brownell wrote:
> Linus Torvalds wrote:
> 
> >... would never have
> >compiled with debugging on anyway. 
> 
> Speaking of which, please consider merging this.  It
> missed Greg's push on Friday, but it's needed to build
> OHCI and EHCI with CONFIG_USB_DEBUG when !CONFIG_PM.

I'm making up a few more patches to send to Linus tomorrow with a few
bug fixes like this for the USB code.  I'll fix this up properly...

thanks,

greg k-h

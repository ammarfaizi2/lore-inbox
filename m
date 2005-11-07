Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVKGWJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVKGWJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVKGWJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:09:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:36316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965003AbVKGWJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:09:07 -0500
Date: Mon, 7 Nov 2005 13:52:26 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net
Subject: Re: 2.6.14-mm1: Why is USB_LIBUSUAL user-visible?
Message-ID: <20051107215226.GA25104@kroah.com>
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107211028.GU3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107211028.GU3847@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:10:28PM +0100, Adrian Bunk wrote:
> On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.14-rc5-mm1:
> >...
> > +gregkh-usb-usb-libusual.patch
> > 
> >  USB tree updates
> >...
> 
> IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> should be automatically enabled when it makes sense.

The trick is, when does it "make sense"?

Anyone have any ideas?

thanks,

greg k-h

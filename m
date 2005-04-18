Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVDRUGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVDRUGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVDRUG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:06:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:62153 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262195AbVDRUG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:06:27 -0400
Date: Mon, 18 Apr 2005 11:14:37 -0700
From: Greg KH <greg@kroah.com>
To: Andy Armstrong <andy@hexten.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.7 1/2] USB HID: Patch for Cherry CyMotion Linux keyboard
Message-ID: <20050418181437.GA16966@kroah.com>
References: <37b978ceccdb5fbea39a925ea9eaa2cb@hexten.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b978ceccdb5fbea39a925ea9eaa2cb@hexten.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 05:41:46PM +0100, Andy Armstrong wrote:
> For those who haven't seen it the Cherry CyMotion Linux keyboard is a 
> decent quality keyboard with the Windows specific keys replaced with 
> Linux keys. It's got a nice little picture of Tux on it too. The 
> supplied patches aren't suitable for current kernels so I've bashed 
> their patches into a suitable form.

Your patches are line-wrapped, and the tabs were stripped out :(

Care to redo them, add a signed-off-by: line and send them to the
linux-usb-devel mailing list and CC: the hid maintainer?

thanks,

greg k-h

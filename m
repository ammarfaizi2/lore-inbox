Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUB0Qde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUB0Qde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:33:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:31713 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263037AbUB0Qdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:33:32 -0500
Date: Fri, 27 Feb 2004 08:32:42 -0800
From: Greg KH <greg@kroah.com>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [USB, SCANNER] scanner.ko removed, but documentation remains
Message-ID: <20040227163242.GA9140@kroah.com>
References: <87y8qols2n.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8qols2n.fsf@echidna.jochen.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:44:48AM +0100, Jochen Hein wrote:
> 
> That was the ChangeLog to 2.6.3:
> 
> <greg@kroah.com>
>         [PATCH] USB: remove scanner driver files.
> 
> 
> I think that ./Documentation/usb/scanner.txt should be removed or
> rewritten to point to libusb for scanner access.

Good point, I'll take care of that in the next round of USB patches.

thanks,

greg k-h

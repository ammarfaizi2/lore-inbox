Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVCRWa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVCRWa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVCRWa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:30:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:6333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262435AbVCRWaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:30:24 -0500
Date: Fri, 18 Mar 2005 14:30:04 -0800
From: Greg KH <gregkh@suse.de>
To: Milan Svoboda <milan.svoboda@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops, 2.6.11.3
Message-ID: <20050318223004.GA18675@kroah.com>
References: <200503182103.59649.milan.svoboda@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503182103.59649.milan.svoboda@centrum.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 09:03:59PM +0100, Milan Svoboda wrote:
> Hello,
> 
> usbnet (iPAQ with Familiar) and harddisk connected throught usb were in use 
> during this oops.
> 
> HW: HP Omnibook xt6200

Does this happen with preempt disabled?

thanks,

greg k-h

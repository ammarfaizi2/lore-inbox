Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUELQ1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUELQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUELQ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:27:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:49860 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265121AbUELQ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:27:29 -0400
Date: Wed, 12 May 2004 09:26:48 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 breaks my Logitech USB mouse
Message-ID: <20040512162648.GB12270@kroah.com>
References: <20040512131306.GA241@fefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512131306.GA241@fefe.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 03:13:06PM +0200, Felix von Leitner wrote:
> 
> 2.6.6 never reaches the "input: " line.  What gives?

Don't know, can you enable CONFIG_USB_DEBUG and send the kernel log to
the linux-usb-devel mailing list?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVAUIoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVAUIoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAUIoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:44:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:63117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262319AbVAUIoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:44:14 -0500
Date: Fri, 21 Jan 2005 00:36:50 -0800
From: Greg KH <greg@kroah.com>
To: Alexander Fieroch <Fieroch@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb storage device bug in kernel module - I/O error
Message-ID: <20050121083650.GA20115@kroah.com>
References: <csp6oq$pld$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csp6oq$pld$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:10:49PM +0100, Alexander Fieroch wrote:
> Hello kernel list,
> 
> I don't know if this is the right list for problems with kernel modules
> and bugs - if not please tell me where I can find the kernel development
> mailing list to report this.

This is the right list, but you might want to post this to the
linux-usb-devel mailing list, where the usb-storage driver authors are.
They should be able to help you out.

good luck,

greg k-h

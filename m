Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbUDNRFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbUDNRFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:05:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:26086 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264281AbUDNRFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:05:02 -0400
Date: Wed, 14 Apr 2004 09:57:15 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] USB speedtouch: turn on debugging if CONFIG_USB_DEBUG is set
Message-ID: <20040414165715.GA7945@kroah.com>
References: <200404131112.04621.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404131112.04621.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 11:12:04AM +0200, Duncan Sands wrote:
> Hi Greg, this causes the speedtouch driver to output non-verbose
> debugging messages if the kernel was configured with CONFIG_USB_DEBUG.
> The patch is against your 2.6 kernel tree.

Applied, thanks.

greg k-h

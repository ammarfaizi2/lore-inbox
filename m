Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbUDNRHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbUDNRHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:07:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:11495 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264294AbUDNRGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:06:45 -0400
Date: Wed, 14 Apr 2004 09:57:31 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB speedtouch: bump the version number
Message-ID: <20040414165731.GC7945@kroah.com>
References: <200404131119.26807.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404131119.26807.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 11:19:26AM +0200, Duncan Sands wrote:
> Hi Greg, this patch bumps the speedtouch driver's version number.
> It also adds the version number to the module description, so people
> can see it with modinfo.  I also added a MODULE_VERSION line (why?
> because it was there...)  The patch is against your 2.6 kernel tree.

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUDISvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUDISvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:51:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:20412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261624AbUDISvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:51:40 -0400
Date: Fri, 9 Apr 2004 11:32:21 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Karsten Keil <kkeil@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
Subject: Re: [PATCH] Add sysfs class support for CAPI
Message-ID: <20040409183220.GA16842@kroah.com>
References: <1081516925.13202.8.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081516925.13202.8.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 03:22:05PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> here is a patch that adds class support to the ISDN CAPI module. Without
> it udev won't create the /dev/capi20 device node.

Looks good, applied, thanks.

greg k-h

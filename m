Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFVPEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFVPEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFVPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:03:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:43430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261470AbVFVPAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:00:01 -0400
Date: Wed, 22 Jun 2005 07:59:48 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian@popies.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: usb sysfs intf files no longer created when probe fails
Message-ID: <20050622145948.GA1883@kroah.com>
References: <1119448257.4587.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119448257.4587.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:50:56PM +0200, Stelian Pop wrote:
> I use the 'atp' input driver from http://popies.net/atp/ to drive this
> touchpad. When removing the driver I also get an oops, possibly related
> to the previous failure to create the sysfs file:

Sounds like a bug in that driver, care to ask the authors of it about
this?

thanks,

greg k-h

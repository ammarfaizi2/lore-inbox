Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVEYETf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVEYETf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 00:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEYETf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 00:19:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:9435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262259AbVEYETc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 00:19:32 -0400
Date: Tue, 24 May 2005 21:26:21 -0700
From: Greg KH <greg@kroah.com>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_HOTPLUG, 2.4.x and ppc
Message-ID: <20050525042621.GB17299@kroah.com>
References: <200505250241.j4P2fJtP024511@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505250241.j4P2fJtP024511@dell.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 10:41:18PM -0400, Marty Leisner wrote:
> 
> I'm dealing with a custom BRIDGE_OTHER chip, which has PCI devices
> on the other side...the configuration cycles don't follow a standard, and
> I'm trying to establish the bus behind the bridge when I install a module...
> essentially I'm doing things similar to hotplug drivers...
> 
> I have no experience with hotplug drivers, but it appears to be incompatible
> with the ppc architure...

What pci hotplug controller works on the ppc platform on the 2.4 kernel?

thanks,

greg k-h

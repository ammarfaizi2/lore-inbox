Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136084AbRECEcX>; Thu, 3 May 2001 00:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbRECEcN>; Thu, 3 May 2001 00:32:13 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:4 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S136084AbRECEcE>;
	Thu, 3 May 2001 00:32:04 -0400
Date: Wed, 2 May 2001 20:31:09 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Compaq Hotplug PCI driver for 2.4.4
Message-ID: <20010502203109.A31824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to let linux-kernel know:

I'm working on the Compaq Hotplug PCI driver.  The latest version should
work with most Intel motherboards that support Hotplug PCI.  The patch
is currently available against 2.4.4 at:
	http://www.kroah.com/linux/hotplug/

Many thanks to Dely Sy at Intel for his help in getting the driver
working on my motherboard.

There is much more to be done to the driver before it can be included in
the kernel tree, but if anyone wants to try it out, please do.

thanks,

greg k-h

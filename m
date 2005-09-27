Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVI0HUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVI0HUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVI0HUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:20:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:6607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964845AbVI0HUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:20:00 -0400
Date: Mon, 26 Sep 2005 17:28:25 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 02/28] I2O: remove i2o_device_class
Message-ID: <20050927002825.GA11826@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.068231000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915070302.068231000.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:01:33AM -0500, Dmitry Torokhov wrote:
> I2O: cleanup - remove i2o_device_class
> 
> I2O devices reside on their own bus so there should be no reason
> to also have i2c_device class that mirros i2o bus.

Ok, nice, this is good.  But it doesn't apply at all, somethings odd.
What tree is this diffed against, Linus's or -mm?

thanks,

greg k-h

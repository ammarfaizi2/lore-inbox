Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWGCXHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWGCXHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWGCXHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:07:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58556 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750826AbWGCXHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:07:54 -0400
Message-ID: <44A9A345.8040706@garzik.org>
Date: Mon, 03 Jul 2006 19:07:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] change netdevice to use struct device instead of struct
 class_device
References: <20060703224719.GA14176@kroah.com>
In-Reply-To: <20060703224719.GA14176@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I have a patch here that converts the network device structure to use
> the struct device instead of struct class_device structure.  It's a bit
> too big to post here, so it's at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/network-class_device-to-device.patch

So....  this is a userspace ABI change, then?

	Jeff




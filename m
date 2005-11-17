Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVKQWGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVKQWGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVKQWGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:06:40 -0500
Received: from digitalimplant.org ([64.62.235.95]:8109 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932277AbVKQWGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:06:40 -0500
Date: Thu, 17 Nov 2005 14:06:28 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Small fixups to driver core
In-Reply-To: <Pine.LNX.4.44L0.0511171444400.4452-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.50.0511171405410.24560-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0511171444400.4452-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Nov 2005, Alan Stern wrote:

> Greg:
>
> This patch (as603) makes a few small fixes to the driver core:
>
> 	Change spin_lock_irq for a klist lock to spin_lock;
>
> 	Fix reference count leaks;
>
> 	Minor spelling and formatting changes.

> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by Patrick Mochel <mochel@digitalimplant.org>


Thanks,


	Pat


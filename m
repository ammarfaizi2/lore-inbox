Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274877AbTHFGQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274878AbTHFGQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:16:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:6609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274877AbTHFGQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:16:15 -0400
Date: Tue, 5 Aug 2003 22:33:36 -0700
From: Greg KH <greg@kroah.com>
To: Dee <dfisher@uptimedevices.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb oops palm-link sony clie
Message-ID: <20030806053336.GB6966@kroah.com>
References: <20030804215543.6b718d0d.dfisher@uptimedevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804215543.6b718d0d.dfisher@uptimedevices.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 09:55:43PM -0500, Dee wrote:
> 
> 	when syncing at the end it hangs palm-link and the oops happens.
> I have to reboot to get it to reset.

Known bug, use 2.6 instead :)

Seriously, search the archives for more info if you are curious...

thanks,

greg k-h

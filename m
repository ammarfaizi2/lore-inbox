Return-Path: <linux-kernel-owner+willy=40w.ods.org-S276856AbUKBALl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276856AbUKBALl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381917AbUKAXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:30:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:35016 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S379327AbUKAWyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:54:19 -0500
Date: Mon, 1 Nov 2004 14:43:14 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 1/4] Driver core: add driver symlink to device
Message-ID: <20041101224314.GA17618@kroah.com>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com> <20041029202249.GB29171@kroah.com> <200410300326.23345.dtor_core@ameritech.net> <200410300327.24589.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410300327.24589.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 03:27:22AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1955, 2004-10-30 01:08:14-05:00, dtor_core@ameritech.net
>   Driver core: when binding device to a driver create "driver"
>                symlink in device's directory. Rename serio's
>                "driver" attribute to "drvctl" (write-only)
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Ok, I've applied this one, as it was very simple.

I'll get to your other patches tomorrow, need to get a pci and usb
update out today...

thanks for your patience, we'll get there eventually :)

greg k-h

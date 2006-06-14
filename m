Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWFNXO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWFNXO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWFNXOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:14:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:33960 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965009AbWFNXOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:14:54 -0400
Date: Wed, 14 Jun 2006 16:14:59 -0700
From: Greg KH <gregkh@suse.de>
To: Kevin Lloyd <klloyd@sierrawireless.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New VID/PID combos for airprime driver and WWAN support
Message-ID: <20060614231459.GA23025@suse.de>
References: <3415E2A2AB26944B9159CDB22001004D19DE66@nestea.sierrawireless.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3415E2A2AB26944B9159CDB22001004D19DE66@nestea.sierrawireless.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 04:01:38PM -0700, Kevin Lloyd wrote:
>   
> 
> To Whom It May Concern:
> 
>  
> I would like to know whom it is I should talk to in order to discuss the
> disclosure of new VID/PID combos for the usb-serial airprime
> driver/module. Sierra Wireless (which has acquired AirPrime) continues
> to make Wireless WAN products and would like to continue support of them
> in Linux.

You can just send me patches with the new device ids, in the format
described in Documentation/SubmittingPatches, and that will get the new
devices supported properly.

I also have a few questions as to the speed of the current driver (it
sucks).  I have a patch that was posted to the linux-usb-devel mailing
list to improve this, but it's only working for about half of the users.
Are there differences with the different airprime devices that we should
be aware of?

Anything else that you feel that would help make the driver better would
be greatly appreciated.

thanks,

greg k-h

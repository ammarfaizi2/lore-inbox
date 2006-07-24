Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWGXTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWGXTrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGXTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:47:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:26346 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751421AbWGXTrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:47:37 -0400
Date: Mon, 24 Jul 2006 12:38:08 -0700
From: Greg KH <gregkh@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-ID: <20060724193808.GA9244@suse.de>
References: <20060712232359.GA22679@kroah.com> <20060724212146.498d184b.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724212146.498d184b.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 09:21:46PM +0200, Jean Delvare wrote:
> > Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
> > bugs and update the documentation.
> > 
> > They all have been in the -mm tree for a while.
> > 
> > Please pull from:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> > or from:
> > 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> > if it isn't synced up yet.
> > 
> > The full patch series will sent to the sensors mailing list, if anyone
> > wants to see them.
> 
> Which is quite unfortunate because we now have a new mailing list
> dedicated to i2c [1], where the i2c patches would fit better. Is it
> possible to send the i2c patches to the i2c list next time? And the
> hwmon patches to the sensors list as before.

I can do that if you want me to split up the hwmon and i2c patches into
two different set of patches for Linus to pull from.  If you think it's
worth it, I will.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWGXTVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWGXTVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGXTVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:21:45 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:60683 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751355AbWGXTVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:21:44 -0400
Date: Mon, 24 Jul 2006 21:21:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-Id: <20060724212146.498d184b.khali@linux-fr.org>
In-Reply-To: <20060712232359.GA22679@kroah.com>
References: <20060712232359.GA22679@kroah.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
> bugs and update the documentation.
> 
> They all have been in the -mm tree for a while.
> 
> Please pull from:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> or from:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> if it isn't synced up yet.
> 
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

Which is quite unfortunate because we now have a new mailing list
dedicated to i2c [1], where the i2c patches would fit better. Is it
possible to send the i2c patches to the i2c list next time? And the
hwmon patches to the sensors list as before.

[1] http://lists.lm-sensors.org/mailman/listinfo/i2c

Thanks,
-- 
Jean Delvare

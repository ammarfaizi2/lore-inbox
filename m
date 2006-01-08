Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752640AbWAHPiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbWAHPiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 10:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbWAHPiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 10:38:17 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:52494 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1752640AbWAHPiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 10:38:17 -0500
Date: Sun, 8 Jan 2006 16:38:29 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [GIT PATCH] I2C and hwmon patches for 2.6.15
Message-Id: <20060108163829.49eb7eee.khali@linux-fr.org>
In-Reply-To: <20060106220642.GA19212@kroah.com>
References: <20060106220642.GA19212@kroah.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here are some i2c and hwmon patches.  They add a new hwmon driver and
> fix a number of different bugs.  All of these have been in the last few
> -mm releases.
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> or from:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> if it isn't synced up yet.
> 
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

I checked the patches and everything is in order :) Thanks!

I also backported a few of these changes to i2c CVS and lm_sensors CVS.

-- 
Jean Delvare

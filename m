Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWCXJBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWCXJBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWCXJBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:01:09 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:11278 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1422748AbWCXJBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:01:07 -0500
Date: Fri, 24 Mar 2006 10:01:46 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C and hwmon patches for 2.6.16
Message-Id: <20060324100146.835b24a9.khali@linux-fr.org>
In-Reply-To: <20060323224306.GA32322@kroah.com>
References: <20060323224306.GA32322@kroah.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here are some i2c and hwmon patches for against your current git tree.
> They all have been in the -mm tree for a few weeks and months.
> 
> They fix a number of various bugs and add some new drivers and features
> (hm, that was sure vague, see the changelog below for details...)

Vague, and wrong too ;) No new driver this time around.

I've checked all the patches and they match my own stack, so this is a
successful resync once again. Well done!

You still have 10 pending patches from me though (sent yesterday) and
there will most certainly be at least two more by the end of the week
(two RTC i2c drivers use tasklets in forbidden conditions and need to
be fixed.)

Thanks,
-- 
Jean Delvare

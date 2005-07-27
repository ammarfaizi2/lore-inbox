Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVG0UZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVG0UZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVG0UW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:22:58 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:6163 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S262471AbVG0UUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:20:38 -0400
Date: Wed, 27 Jul 2005 22:21:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core
 (2/9)
Message-Id: <20050727222112.423353a4.khali@linux-fr.org>
In-Reply-To: <20050726225411.GA5606@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org>
	<20050719234843.14cfb1ec.khali@linux-fr.org>
	<20050720042755.GD26552@kroah.com>
	<20050720234603.2b66560d.khali@linux-fr.org>
	<20050725003551.GE9824@kroah.com>
	<20050725192827.0b166d1e.khali@linux-fr.org>
	<20050726225411.GA5606@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > You can take a look at my current stack here for reference:
> > http://khali.linux-fr.org/devel/i2c/linux-2.6/series
> 
> Ok, should be caught up now.  I have a pci patch or two still left to
> apply that i know you were also tracking.

I've picked up the few i2c patches you have and I didn't, and just
posted the ones I had and you didn't to the the sensors list, so we
should be sync'd again soon now.

As for PCI, I only have one patch pending and it seems you have it
already, so it's OK.

Thanks,
-- 
Jean Delvare

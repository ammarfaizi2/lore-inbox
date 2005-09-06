Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVIFTJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIFTJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVIFTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:09:35 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:38660 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750806AbVIFTJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:09:34 -0400
Date: Tue, 6 Sep 2005 21:09:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [GIT PATCH] I2C patches for 2.6.13
Message-Id: <20050906210953.19b4b956.khali@linux-fr.org>
In-Reply-To: <20050905214431.GA5897@kroah.com>
References: <20050905214431.GA5897@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here are a bunch of I2C and HWMON patches that have been in the -mm
> tree for a while.  There is a bunch of hwmon and i2c driver split up
> changes, and some i2c api reworks to reduce the size of the
> structures, and the size of the kernel code (which accounts for all of
> the small changes to all of the sensor and i2c drivers across the
> whole kenel tree.)  There are also a few new drivers added to the
> tree.
> (...)
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

I checked against my own list, and it looks all OK to me. Thanks :)

There are two old patches I have and you don't, but it turns out that I
probably never sent them in the first place (I can't find a trace in the
mailing list archive.) I will send them now. These are really minor
changes anyway, nothing to worry about.

Thanks again,
-- 
Jean Delvare

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWGZUBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWGZUBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWGZUBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:01:12 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:14353 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751775AbWGZUBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:01:11 -0400
Date: Wed, 26 Jul 2006 22:01:21 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-Id: <20060726220121.89fda898.khali@linux-fr.org>
In-Reply-To: <20060724193808.GA9244@suse.de>
References: <20060712232359.GA22679@kroah.com>
	<20060724212146.498d184b.khali@linux-fr.org>
	<20060724193808.GA9244@suse.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> On Mon, Jul 24, 2006 at 09:21:46PM +0200, Jean Delvare wrote:
> > > Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
> > > bugs and update the documentation.
> > > (...)
> > > The full patch series will sent to the sensors mailing list, if anyone
> > > wants to see them.
> > 
> > Which is quite unfortunate because we now have a new mailing list
> > dedicated to i2c [1], where the i2c patches would fit better. Is it
> > possible to send the i2c patches to the i2c list next time? And the
> > hwmon patches to the sensors list as before.
> 
> I can do that if you want me to split up the hwmon and i2c patches into
> two different set of patches for Linus to pull from.  If you think it's
> worth it, I will.

Yes, please. Else people will never get that i2c and hwmon are
different things (although they intersect.)

Thanks,
-- 
Jean Delvare

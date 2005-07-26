Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVGZW6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVGZW6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVGZW4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:56:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:29320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262312AbVGZWz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:55:28 -0400
Date: Tue, 26 Jul 2005 15:54:11 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (2/9)
Message-ID: <20050726225411.GA5606@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org> <20050719234843.14cfb1ec.khali@linux-fr.org> <20050720042755.GD26552@kroah.com> <20050720234603.2b66560d.khali@linux-fr.org> <20050725003551.GE9824@kroah.com> <20050725192827.0b166d1e.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725192827.0b166d1e.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 07:28:27PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> > Ah, much better, thanks.  Sounds like a great plan, I'll go apply your
> > patches in a day or so when I catch up from my travels.
> 
> OK, thanks.
> 
> Note that there are a few patches which you should apply before this
> series, in particular Mark Hoffman's 3 hwmon class patches. There are no
> hard dependencies between both series but applying them in order is
> likely to ease your work.
> 
> You can take a look at my current stack here for reference:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/series

Ok, should be caught up now.  I have a pci patch or two still left to
apply that i know you were also tracking.

thanks,

greg k-h

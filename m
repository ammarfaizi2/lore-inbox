Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVGYEXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVGYEXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 00:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVGYEW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 00:22:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:40167 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261680AbVGYEWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 00:22:36 -0400
Date: Sun, 24 Jul 2005 20:35:51 -0400
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (2/9)
Message-ID: <20050725003551.GE9824@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org> <20050719234843.14cfb1ec.khali@linux-fr.org> <20050720042755.GD26552@kroah.com> <20050720234603.2b66560d.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720234603.2b66560d.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 11:46:03PM +0200, Jean Delvare wrote:
> 
> So, the approximate timeline would be 1* to 3* right now, 4* after that
> as time permits, and 5* when we estimate that 3* happened long enough
> ago (roughly 1st half of 2006?)
> 
> I hope I explained it correctly this time. If not, just complain ;)

Ah, much better, thanks.  Sounds like a great plan, I'll go apply your
patches in a day or so when I catch up from my travels.

thanks,

greg k-h

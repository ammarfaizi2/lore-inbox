Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVI2MDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVI2MDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVI2MDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:03:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:47806 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751051AbVI2MDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:03:13 -0400
Date: Wed, 28 Sep 2005 13:05:47 -0700
From: Greg KH <greg@kroah.com>
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Change of I2C kernel subsystem maintainer
Message-ID: <20050928200547.GA10995@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If people hadn't noticed anymore, I've passed on the full I2C subsystem
maintainership to Jean Delvare <khali@linux-fr.org>.  He and I had been
"sharing" it for the past months, but now he's more than capable of
handling the whole thing, and I know it is in good hands now.

So, for any I2C driver questions or patches, please feel free to let him
know, don't send them to me anymore, please :)

I'll still be paying attention to the I2C core work, especially where it
touches the driver core interfaces, and have some pending work to clean
up in that area.  I'll also remain the conduit for sending I2C and hwmon
stuff on to Andrew for the -mm tree, and Linus for the mainline tree, so
nothing will change there.

thanks,

greg k-h

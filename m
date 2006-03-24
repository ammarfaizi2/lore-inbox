Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWCXTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWCXTMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCXTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:12:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:13001 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964790AbWCXTMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:12:48 -0500
Date: Fri, 24 Mar 2006 11:06:33 -0800
From: Greg KH <gregkh@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C and hwmon patches for 2.6.16
Message-ID: <20060324190633.GA2650@suse.de>
References: <20060323224306.GA32322@kroah.com> <20060324100146.835b24a9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324100146.835b24a9.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 10:01:46AM +0100, Jean Delvare wrote:
> You still have 10 pending patches from me though (sent yesterday) and
> there will most certainly be at least two more by the end of the week
> (two RTC i2c drivers use tasklets in forbidden conditions and need to
> be fixed.)

Yes, those patches are in my todo queue, and will get to them later
today.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVBQWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVBQWnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVBQWnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:43:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:33409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261209AbVBQWky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:40:54 -0500
Date: Thu, 17 Feb 2005 14:25:40 -0800
From: Greg KH <greg@kroah.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-ID: <20050217222540.GE21188@kroah.com>
References: <42094ADB.9040403@mvista.com> <58cb370e05020816017431b38@mail.gmail.com> <42095A0B.2080400@mvista.com> <58cb370e05020817241aa42631@mail.gmail.com> <420A81C7.1000108@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A81C7.1000108@mvista.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 02:33:59PM -0700, Mark A. Greer wrote:
> 
> I can't find any definitive policy on this.  I kind of like the explicit 
> return, I don't know why.  I've had others make the same comment, 
> though, so I'll remove them since it obviously bothers people.
> 
> Attached is a replacement patch.
> 
> Thanks again, Bartlomiej.
> 
> Mark
> --
> Marvell makes a line of host bridge for PPC and MIPS systems.  On those 
> bridges is an i2c controller.  This patch adds the driver for that i2c 
> controller.
> 
> Please apply.
> 
> Depends on patch submitted by Jean Delvare: 
> http://archives.andrew.net.au/lm-sensors/msg29405.html
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Applied, thanks.

greg k-h


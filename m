Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUIVP4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUIVP4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUIVP4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:56:43 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:35250 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S266181AbUIVP4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:56:42 -0400
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
From: Adrian Cox <adrian@humboldt.co.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <9e47339104092208403d9de6f4@mail.gmail.com>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com> <41506099.8000307@web.de>
	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
	 <9e47339104092208403d9de6f4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095868579.18365.105.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 16:56:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 16:40, Jon Smirl wrote:

> Any DDC solution needs to leave the data visible in sysfs and
> accessible from user space. I'm trying to move the EDID parsing code
> out of the kernel.

Would it do for a display device to expose read-only EDID data through
sysfs, or do you need I2C level access to DDC from userspace?

- Adrian Cox
Humboldt Solutions Ltd.



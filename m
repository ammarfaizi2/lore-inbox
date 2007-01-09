Return-Path: <linux-kernel-owner+w=401wt.eu-S932222AbXAIRHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbXAIRHL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAIRHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:07:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46052 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbXAIRHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:07:09 -0500
Date: Tue, 9 Jan 2007 17:05:55 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Luming Yu <luming.yu@gmail.com>
cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 1/5] video sysfs support - take 2: Add dev argument for
 backlight_device_register.
In-Reply-To: <3877989d0701090709n32f57048o495274849cbbf127@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701091705030.17932@pentafluge.infradead.org>
References: <200611080033.56035.luming.yu@gmail.com> 
 <1167492935.5626.12.camel@localhost.localdomain>
 <3877989d0701090709n32f57048o495274849cbbf127@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > To top it off, someone noticed some of the failures and fixed them but
> > nobody thought to fix the drivers in drivers/video/backlight itself and
> > a mac reference seems to have escaped too.
> 
> If my memory serves me well,  there is a patch for mac in mm.
> Not sure other drivers in video/backlight. But I should have sent it
> to some place.
> Need to check.

I sent a patch some time ago to Andrew Morton for the fbdev drivers in 
the video directory. I belive that patch is main stream now.


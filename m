Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVKGK0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKGK0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVKGK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:26:06 -0500
Received: from webapps.arcom.com ([194.200.159.168]:64523 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S964816AbVKGK0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:26:05 -0500
Message-ID: <436F2BB2.3040008@cantab.net>
Date: Mon, 07 Nov 2005 10:25:54 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Richard Purdie <rpurdie@rpsys.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, dkrivoschokov@dev.rtsoft.ru
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
References: <20051103221402.GA28206@elf.ucw.cz> <1131057308.8523.92.camel@localhost.localdomain> <20051106204506.GH29901@elf.ucw.cz>
In-Reply-To: <20051106204506.GH29901@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 10:27:14.0515 (UTC) FILETIME=[D21C4230:01C5E385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> ...for the spitz. Do you think I can just copy this one? ...eh, no,
> will not fly, there's no SPITZ_GPIO_USB_PULLUP.

There are internal pull-ups (and pull-downs) perhaps you can use those?

Hmmm. Though the C5 stepping might be different -- best to check the
"specification update".

David Vrabel

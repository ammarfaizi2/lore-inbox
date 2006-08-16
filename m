Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWHPIgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWHPIgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWHPIgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:36:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:63412 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751006AbWHPIgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:36:13 -0400
Date: Wed, 16 Aug 2006 01:35:21 -0700
From: Greg KH <greg@kroah.com>
To: liyu <liyu@ccoss.com.cn>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, liyu <raise_sail@163.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb: The HID Simple Driver Interface 0.3.1 (core)
Message-ID: <20060816083521.GB24139@kroah.com>
References: <20060816030004.GC5206@martell.zuzino.mipt.ru> <44E2B9D0.7030109@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E2B9D0.7030109@ccoss.com.cn>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:23:12PM +0800, liyu wrote:
> 
> Well, Where I can get some guide for how use #ifdef/#if ?

Documentation/CodingStyle.

Basically, don't use it in .c files, but only in .h files if necessary.

> Also, I found I can not send mail to <linux-kernel@vger.kernel.org> now,
> the reject reply like this:
> 
> Connected to 209.132.176.167 but sender was rejected.
> Remote host said: 553 5.7.1 Hello [210.76.114.181], for your MAIL FROM address <liyu@ccoss.com.cn> policy analysis reported: Your address is not liked source for email
> 
> 
> Is it looked my mail as spam mail? Who should I send to for help me
> resolving this problem?

Go here:
	http://vger.kernel.org/mxverify.html
to see how to fix this up.

good luck,

greg k-h

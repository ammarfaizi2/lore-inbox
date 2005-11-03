Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVKCWfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVKCWfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVKCWfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:35:47 -0500
Received: from tim.rpsys.net ([194.106.48.114]:27565 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932571AbVKCWfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:35:47 -0500
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       dkrivoschokov@dev.rtsoft.ru
In-Reply-To: <20051103221402.GA28206@elf.ucw.cz>
References: <20051103221402.GA28206@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 22:35:08 +0000
Message-Id: <1131057308.8523.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 23:14 +0100, Pavel Machek wrote:
> Is there recent version somewhere? I found one version
> (pxa27x-0218.patch), but it is *really* old.

Pull it out of handhelds.org kernel26 cvs tree and let me and the usb
developers have the patch please :)

> I'd like to connect zaurus c-3000 to desktop somehow... what is the
> recommended way? I wanted to use bluetooth originally, but billionton
> card is way too slow.

I use a CF wifi card.

USB Host works so a usb host<->host cable might work but is untested.

> Is there chance for usb-gadget support for collie (sl-5500, sa1100
> cpu)?

I think 2.4 drivers exist but nothing for 2.6 :-(. Someone needs to
write that driver...

Richard




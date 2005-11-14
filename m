Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVKNNUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVKNNUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 08:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKNNUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 08:20:31 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:59520 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751112AbVKNNUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 08:20:30 -0500
Message-ID: <43788F17.1080507@rtr.ca>
Date: Mon, 14 Nov 2005 08:20:23 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1: kswapd crash
References: <4377D1B2.8070003@rtr.ca> <20051114004758.GA5735@stusta.de> <4377FFA7.4030400@rtr.ca> <20051114035616.GD5735@stusta.de>
In-Reply-To: <20051114035616.GD5735@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> So why did you delete the tainted line from the Oops output you sent?

I didn't.  Strictly a cut and paste, no changes.

> It might be a bug in the kernel or a bug in your vmware modules exposed 
> by the new kernel.

It's not.  VMware had never been run to that point.
There's something wrong with this kernel,
that wasn't wrong with 2.6.13.

Dunno what yet.  It may never crash again,
or it might do it Windows-style on some machines.

Just a data point for Linus, that's all.

Cheers

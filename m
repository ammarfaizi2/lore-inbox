Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTEIURK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTEIURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:17:10 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:34555 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261661AbTEIURJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:17:09 -0400
Message-ID: <3EBC12A7.4040706@pacbell.net>
Date: Fri, 09 May 2003 13:42:15 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, torvalds@transmeta.com
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB Gadget core and driver for 2.5.69
References: <20030508215102.GA3538@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way:

>   There's additional kerneldoc, which I won't submit at
>   this time, available.

That kerneldoc is available, pre-formatted as PDF, at

    http://kernel.bkbits.net/~david-b/gadget.pdf

The first several pages give an overview of the API and
how to use it, including the "layer cake" model that so
many folk like, and a driver lifecycle description.  The
rest is mostly what's in the <linux/usb_gadget.h> header.

- Dave


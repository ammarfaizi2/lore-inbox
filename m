Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTEKOaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTEKOaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:30:25 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:51627 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S261454AbTEKOaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:30:24 -0400
Date: Sun, 11 May 2003 07:57:16 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] kbuild/kbuild for USB Gadgets (6/6)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <3EBE64CC.3090907@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.GSO.4.21.0305111102530.11279-100000@vervain.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
>>+	   USB is a master/slave protocol, organized with with one master
> 
>                                                      ^^^^^^^^^
> with with

Yes, that could stand to be fixed.
Speling erors -- we hates them forever!


>>+	  Make this be the first driver you try using on top of any new
> 
>           ^^^^^^^^^^^^
> Shouldn't the `be' be removed?

It's OK there, and some might say preferred.


>>+	  but is widely suppored by firmware for smart network devices.
> 
>                         ^^^^^^^^
> supported

Beat you -- the fix for that typo is already in Linus' tree!

- Dave




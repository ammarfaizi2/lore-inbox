Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVBLRv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVBLRv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 12:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBLRv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 12:51:58 -0500
Received: from mx.freeshell.org ([192.94.73.21]:29426 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261174AbVBLRvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 12:51:55 -0500
Date: Sat, 12 Feb 2005 17:50:47 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501122242.51686.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0502121749290.25663@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501110239.33260.dtor_core@ameritech.net> <Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
 <200501122242.51686.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again Dmitry,

is there anything new about this issue? any fixes in the kernel?
If you want, I can continue doing the test/debug cycle as before.

Roey


On Wed, 12 Jan 2005, Dmitry Torokhov wrote:

> Date: Wed, 12 Jan 2005 22:42:51 -0500
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> To: linux-kernel@vger.kernel.org
> Cc: Roey Katz <roey@sdf.lonestar.org>
> Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
> 
> On Wednesday 12 January 2005 10:19 pm, Roey Katz wrote:
>> Dmitry,
>>
>> I have placed the results of the patched 2.6.9-rc2-bk2 kernel at the
>> following address:
>>
>>    http://roey.freeshell.org/mystuff/kernel/*-20050112
>>
>> As expected, the system was unresponsive to keyboard input.
>
> And what if you do not compile PS/2 mouse support in? Is keyboard still
> dead?
>
>> Regarding your mouse question:
>> How do I test the mouse if they keyboard does not work (is there some
>> way to output the contents of /dev/psaux on startup? I'm not sure anymore
>> what file the mouse data appears in, too)
>>
>
> Install GPM and try moving your mouse after booting into runlevel 3 -
> if cursor moves mouse works.
>
> -- 
> Dmitry
>

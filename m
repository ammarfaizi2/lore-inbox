Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbULGIIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbULGIIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbULGIIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:08:13 -0500
Received: from tristate.vision.ee ([194.204.30.144]:35773 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S261754AbULGIH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:07:59 -0500
Message-ID: <41B56518.2070108@vision.ee>
Date: Tue, 07 Dec 2004 10:08:56 +0200
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johan <johan@ccs.neu.edu>, linux-kernel@vger.kernel.org
Subject: Re: status of via velocity in 2.6.9
References: <41B4F447.2060808@ccs.neu.edu>
In-Reply-To: <41B4F447.2060808@ccs.neu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At least Abit AV8 onboard velocity doesn't work with 2.6.9. With earlier 
kernels,
the machine just locked up after ifconfig up. With 2.6.9, it doesn't 
lock up, but it doesn't
work either (data seems to go to black hole or sth). But there seem to 
be some success reports
too with this kernel.

Lenar

Johan wrote:

> How 'working' are the via velocity drivers in 2.6.9?
>
> For better or worse, the cheapest gigabit card I could find has the 
> vt6122 chip, which seems to want the velocity drivers. (*)
>
> Unfortunately, while they (the driver and card, that is) seem at first 
> to work fine, auto negotiating a gigabit connection with my hub, the 
> network stops working after 5 ish minutes (could be function of bytes 
> tx'ed as well, I guess). restarting the network (appart from a kernel 
> upgrade, the box is redhat fc2) fixes the problem... for another 5 
> minutes.
>
> Is this known behavior?
>
> Thanks
>
> Johan
>
> (*) The card's box advertizes linux compatibility with RH 7.3 
> (2.4.18-3 or later), which makes me wonder whether another driver may 
> work better.  2.4.18-3 would seem to predate the via-velocity driver.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



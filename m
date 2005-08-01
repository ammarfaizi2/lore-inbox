Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVHAMVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVHAMVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVHAMS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:18:57 -0400
Received: from [195.23.16.24] ([195.23.16.24]:26841 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261877AbVHAMSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:18:51 -0400
Message-ID: <42EE1324.10304@grupopie.com>
Date: Mon, 01 Aug 2005 13:18:44 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
Subject: Re: IBM HDAPS, I need a tip.
References: <1122861215.11148.26.camel@localhost.localdomain>  <1122872189.5299.1.camel@localhost.localdomain> <1122873057.15825.26.camel@mindpipe> <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>So in order to calibrate it you need a readily available source of
>>constant acceleration, preferably with a known value.
>>
>>Hint: -9.8 m/sec^2.
> 
> Drop it out of the window? :)

No, no. Constant gravity (like having the laptop sitting on the desk) 
"feels like" constant acceleration.

Dropping it out of the window should measure 0 m/sec^2, because the 
accelerometer is not working on an inertial referential (I hope this is 
the correct term in english...). For the accelerometer, this is just 
like the feeling of free falling inside an elevator: no gravity :)

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams

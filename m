Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUARXKf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUARXKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:10:35 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:65202 "EHLO
	mail41.fg.online.no") by vger.kernel.org with ESMTP id S264267AbUARXKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:10:30 -0500
Message-ID: <400B1264.6050600@online.no>
Date: Mon, 19 Jan 2004 00:10:28 +0100
From: Andreas Tolfsen <ato@online.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ken Moffat <ken@kenmoffat.uklinux.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove graphic linux logo on framebuffer, kernel-2-4-24
References: <4241753368.20040118220237@wpk.p.lodz.pl> <Pine.LNX.4.58.0401182123490.9146@ppg_penguin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Moffat wrote:

>
>On Sun, 18 Jan 2004, Szymon Tarnowski wrote:
>
>>
>>Hello everyone
>>  I have made this cosmetic patch to remove linux graphics logo
>>presented during booting system. I have no objection to logo but when
>>console is ready to log in the system, I would like to remove it from
>>screen. Because I don`t have enought programing skils and enought free
>>time to solve this problem, I made this patch to remove logo at all.
>>It is made by changing value sent do framebuffer setup routine. Please
>>fell free to coment my patch, please send it to me directly because I
>>don`t receive subscription from linux-kernel message list. Please also
>>inform me if there will be big discusion at list
>>
>Why ?
>
> If your problem is that a few lines at the top of your screen stay
>blank, there are two existing solutions:
>
>(a) switch to another console, then back.
>
Doing that at every startup?  Bah!

>
>(b) create an init script using `setfont' to set a font of your choice.
>
Well anyway how you see it, having a option for it when making the 
kernel would be very nice.  Then you would have the trouble of making an 
init script every time you install it on a new machine.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVDPR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVDPR5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVDPR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:57:53 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:16336
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262708AbVDPR5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:57:51 -0400
Message-ID: <42615296.8060607@linuxwireless.org>
Date: Sat, 16 Apr 2005 12:59:50 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6 upgrade overall failure report
References: <055FPDS12@server5.heliogroup.fr>
In-Reply-To: <055FPDS12@server5.heliogroup.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I usually never complain, or give negative motivation, but this is a 
reality.

>Now, what's wrong with that ?
>Well, the fact is that new hardware is only supported by latest kernel,
>so at the end, you have to upgrade, and so you get more and more complexity
>whether you like it or not.
>As an example, for servers, 2.4 is still fine, but laptops already require 2.6
>  
>
If it wouldn't be because my wifi card only works in 2.6 and cause the 
speedstep support for my laptop, I would be using 2.4 kernels.

>As a result, the complexity versus stability compromise is less and less
>suited for most real life uses.
>
>Now the problem with the kernel complexity is:
>. ultimate implementation requires much more testing than simple good one (TCP
>  sample)
>. it makes life harder for device drivers writers (tigon3 or fusion sample)
>
I have returned laptops to get them exchanged for one's that have a 
e100/e1000 instead the tigon3. It's a shame that manufacturers still use 
this chip on servers and laptops.

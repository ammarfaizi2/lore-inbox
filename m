Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbTG0Ox2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTG0Ox1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:53:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:62958 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270846AbTG0OxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:53:24 -0400
Message-ID: <3F23EAE9.9090909@freenet.co.uk>
Date: Sun, 27 Jul 2003 16:08:25 +0100
From: D Qi <dqi@freenet.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en,zh
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: snap support in linux
References: <3F23A25A.3050708@freenet.co.uk> <1059302111.12759.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059302111.12759.0.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan,

Thanks for the response. I believe the IPX support(therefore SNAP) can 
be enable with suitable options being enable when compiling the kernel. 
Is it true for ARM porting? Can you point me to the proper place for a 
usable IPX configuration tool?

Thanks,

Alan Cox wrote:
> On Sul, 2003-07-27 at 10:58, D Qi wrote:
> 
>>Is this a issue for the network setting of the running Linux box or some 
>>thing else? Does SNAP frame work by default or is there some thing need 
>>to be done at the driver level? Please help.
> 
> 
> SNAP and IPX over SNAP were working last time I checked. IP over SNAP is
> not supported unless someone added it without me noticing
> 
> 



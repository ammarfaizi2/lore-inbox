Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131241AbRCNAVx>; Tue, 13 Mar 2001 19:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131242AbRCNAVn>; Tue, 13 Mar 2001 19:21:43 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:52096 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S131241AbRCNAVg>; Tue, 13 Mar 2001 19:21:36 -0500
Message-ID: <3AAEB966.311ECB63@bigfoot.com>
Date: Tue, 13 Mar 2001 16:20:54 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM problem with 2.2.18 ?
In-Reply-To: <Pine.LNX.4.21.0103132323450.18168-100000@cyrix.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i had a small problem with a program i was running
> which got stuck in a loop allocing memory by the time i
> found out it was doing it these were appearing
> 
>  VM: do_try_to_free_pages failed for ypbind...
> ...
> etc.. etc.. for many more processes
> then it all ended in a hangup

Patch to 2.2.19pre2 or higher.
http://www.linuxhq.com/kernel/v2.2/changes/pre-2.2.19.html

--

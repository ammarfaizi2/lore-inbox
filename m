Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbUFOURl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUFOURl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUFOURl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:17:41 -0400
Received: from vhost12.digitarus.com ([194.242.150.12]:394 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S265922AbUFOURD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:17:03 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <40CF594C.30109@wiggly.org>
Date: Tue, 15 Jun 2004 21:17:16 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cdrom ripping / dropping to dingle frame dma
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Sorry if this is a completely redundant post but I have not been 
subscribed recently and missed the thread on this.

I have had cdparanoia ripping blank sound off of my cdrom, looking in 
the syslog gives the following just before stuff goes weird.

kernel: cdrom: dropping to single frame dma

Whilst trying to find others with the same problem I have seen an 
archived LKML thread where Jens Axboe provided a patch against 2.6.4-rc1

I am currently running 2.6.5 and am wondering if this patch made it in 
or not, and if not, where I can grab it from.

Alternatively, if this patch should be in 2.6.5 then I have a machine 
that still fails with it, if so I'll be happy to post system specs etc 
and try to find a test CD that exhibits the problem for testing.

Cheers,

   N

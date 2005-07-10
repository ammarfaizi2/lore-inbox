Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVGJDRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGJDRR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVGJDRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:17:17 -0400
Received: from [210.76.114.20] ([210.76.114.20]:4266 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261825AbVGJDRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:17:16 -0400
Message-ID: <42D095D4.3020907@ccoss.com.cn>
Date: Sun, 10 Jul 2005 11:28:20 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: The question come again.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone on LKML:
   
    I am reading slab implement code (2.6.11.11).

    The function kmalloc() is one of the frequently used funtions in 
kernel , of course,
it is one of my focuses.

    But I found it may call __you_cannot_kmalloc_that_much(). but I can 
not get where is
defined. I tried to search in LXR , Source navigator, and run grep in 
include, mm directory,
but nothing to return.

    What's secret in here? Waitting for any answer.

    Thanks.



                                                             liyu
                                                                  NOW~


                                                            

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTDKQIa (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbTDKQIa (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:08:30 -0400
Received: from [203.197.168.150] ([203.197.168.150]:36110 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263021AbTDKQI3 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:08:29 -0400
Message-ID: <3E96EAF5.4060609@tataelxsi.co.in>
Date: Fri, 11 Apr 2003 21:49:01 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tasklet doubt!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

How much of memory can be allocated from a tasklet ? [ kmalloc 
(GFP_ATOMIC) ].

I was able to allocate upto 2.5 MB. But I would like to allocate upto 
8MB. Is this possible?

The physical RAM limit is 64 MB. I am running 2.4.7-10 RH 7.2 on i386.

Any suggestions or pointers could be very helpful.

Thank you.
Regards,
Sriram


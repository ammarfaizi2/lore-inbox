Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267075AbUBEXj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267077AbUBEXj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:39:27 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:59140 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267075AbUBEXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:39:04 -0500
Message-ID: <4022D558.50507@techsource.com>
Date: Thu, 05 Feb 2004 18:44:24 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: KT600, RH9, won't power off, can't find modem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know my first question has been asked before, but google has not been 
forthcoming with an answer, so please excuse my reduncancy.  My second 
question is probably equally stupid.

My colleague has just bought an ABIT KV7 (KT600 chipset) MB, and 
everything seems to work fine with Linux except for two things.  First, 
the kernel version is whatever comes default with RH9 which I think is 
2.4.20-8.

The first problem is that when you tell Linux to power off, the OS halts 
and says it's halted, but it won't automatically power off.

The second problem is that it can't find the modem.  It it a US Robotics 
5660A.  When we got it from CompUSA, we asked if it was a Winmodem, and 
they INSISTED that it was not.  Unfortunately, we can't seem to talk to 
it.  Linux identifies it as a "communications controller", but it 
doesn't seem to appear to be associated with a "serial port" as I (in my 
ignorance) would expect it to be.  Since the modem was installed when we 
installed the OS, I would have expected it to identify it and make sure 
appropriate kernel drivers were installed, but that may be expecting too 
much.  Any suggestions?

The fact that Windows XP insisted that we install drivers from CD to use 
the modem makes me suspicious that the person we asked at CompUSA had 
absolutely no idea what she was talking about, but we can always be 
optimistic.  :)


Thanks!


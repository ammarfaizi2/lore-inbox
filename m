Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbRCJBm7>; Fri, 9 Mar 2001 20:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130799AbRCJBmu>; Fri, 9 Mar 2001 20:42:50 -0500
Received: from f45.law8.hotmail.com ([216.33.241.45]:1291 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130797AbRCJBmm>;
	Fri, 9 Mar 2001 20:42:42 -0500
X-Originating-IP: [24.228.19.252]
From: "s d" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Real Time Clock driver hangs in 2.2.17
Date: Fri, 09 Mar 2001 20:41:55 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F45cF1s5IOiV3XpfbFT00004fb1@hotmail.com>
X-OriginalArrivalTime: 10 Mar 2001 01:41:56.0044 (UTC) FILETIME=[4A2700C0:01C0A903]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using an old Intel Pentium 90 mb -I think its "Plato". It's worked well 
as a gateway and file server for over two years.

When I boot 2.2.17, the machine always hangs at the Real Time Clock driver. 
Pressing any key gets it going, but this is a remote machine - which makes 
it a real pain.

Without a clue, I ve done the following:

I've put in a new cmos battery

I renamed /dev/rtc to dev/somethingelse ( a suggestion from a ng)

Same problem. Is there a way to fix this? rtc.txt doesn't say much. Can I do 
without it? If so, how do I compile the kernel without it?

thanks
jay
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com


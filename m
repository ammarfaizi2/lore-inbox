Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSBDQYf>; Mon, 4 Feb 2002 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289061AbSBDQYZ>; Mon, 4 Feb 2002 11:24:25 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:44147 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289058AbSBDQYU>;
	Mon, 4 Feb 2002 11:24:20 -0500
Message-ID: <3C5EB50E.1000008@debian.org>
Date: Mon, 04 Feb 2002 17:21:34 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <fa.c5n369v.1a10827@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2002 16:24:19.0027 (UTC) FILETIME=[655C5A30:01C1AD98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Balazic wrote:

> Hi!
> 
> This problem again :-)
> 
> I purchase/download a program for linux.
> It says it requires certain kernel features, for example :
> CONFIG_PROC_FS,CONFIG_NET,CONFIG_INET
> 
> How can I figure out in 5 minutes, without a kernel hacker, if
> my linux system has the correct settings ?
> 
> This is a real life question, probably more suitable to ask
> on some distributions mail list, but I thought I'll start here.


I agree: ask to yout distribution mail list. Every distribution
have a different place for kernel configuration.

Anyway:
If you use your distribution kernel, and if your distribution is
not so strange, you have enabled the 3 drivers.

	giacomo

 





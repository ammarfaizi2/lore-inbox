Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316652AbSEWN0D>; Thu, 23 May 2002 09:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316660AbSEWN0C>; Thu, 23 May 2002 09:26:02 -0400
Received: from mailgw.prontomail.com ([209.185.149.10]:49067 "EHLO
	c0mailgw06.prontomail.com") by vger.kernel.org with ESMTP
	id <S316652AbSEWN0B>; Thu, 23 May 2002 09:26:01 -0400
X-Version: beer 7.5.2333.0
From: "will fitzgerald" <william.fitzgerald6@beer.com>
Message-Id: <1864B06FE5DED9149A7F262BF4C5E5DE@william.fitzgerald6.beer.com>
Date: Thu, 23 May 2002 14:21:40 +0100
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: Question:kernel profiling and readprofile
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i stumbled accross a command called readprofile by accident and found 
that by appening the line append="profile=2" to the lilo.conf file 
and using thread profile command you can get statistics on functions 
that spend a certain amount of time doing a job.

i done some searching on this and can't find anything other than a 
man page on readprofile.

can anyone tell me what does the line append="profile=2" actually do 
apart from creating the file profile in the proc directory, what is 
the 2 for in this line?

next is this an accurate way to measure heady traffic load through 
say a linux router? will it highlight all functions say for example 
ip_forward, dev_queue_xmit etc etc that are being opverloaded due to 
huge traffic loads being passed through the router. ie will it spot 
bottlenecks with good accuracy?

any feedback is welcomed,
regards will.

Beer Mail, brought to you by your friends at beer.com.

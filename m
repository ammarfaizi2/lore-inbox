Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276940AbRJKVNf>; Thu, 11 Oct 2001 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276945AbRJKVN0>; Thu, 11 Oct 2001 17:13:26 -0400
Received: from [216.163.180.10] ([216.163.180.10]:50285 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S276940AbRJKVNL>; Thu, 11 Oct 2001 17:13:11 -0400
Message-ID: <3BC60B59.71F0367A@starband.net>
Date: Thu, 11 Oct 2001 17:12:57 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can only login via ssh 1013 times.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before you read this, I just wanted to see how many times I could login.

I would never need 1000+ users support, but others may need it.

So I was just curious to see how many times I could login with ssh
version 1.
I put in 2048 for the number of ptys allowed for the kernel options,
recompiled and installed.

I made a little expect script which would log me in the next time
I login and so on and so forth.
After I logged in 1013? times or so it said "you are out of ptys..."

Once again I have no need for this amount of users, but I was curious,
how many simultaneous users can be logged on to a linux box at one time?

I'll guess @ 1024 considering I had some xterm's open.

Anyone?




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSGUCu4>; Sat, 20 Jul 2002 22:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSGUCu4>; Sat, 20 Jul 2002 22:50:56 -0400
Received: from ns1w.atr.co.jp ([133.186.1.10]:53924 "EHLO mailgw1.atr.co.jp")
	by vger.kernel.org with ESMTP id <S317627AbSGUCuz>;
	Sat, 20 Jul 2002 22:50:55 -0400
Message-ID: <3D3A21EC.5000400@atr.co.jp>
Date: Sun, 21 Jul 2002 11:52:28 +0900
From: "J. Hart" <jhart@atr.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: File Corruption in Kernel 2.4.18
References: <3D362125.3A324489@atr.co.jp> <20020718072155.GB1548@niksula.cs.hut.fi> <3D367295.2010109@gmx.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     I must apologize for the delay in replying to the many helpful 
responses I received on this problem, and I'd like to say "thank you 
very much" (Domo Arigato Gozaimasu) to the many who looked into this on 
my behalf....:-)

Here's the status so far:

     I ran the e2fcsk utility which did not detect any problems on the 
hard drive.  I had not known about the IBM DFT utility until it was 
suggested by one of the responses, so I picked that up and tried it.  I 
ran the quick test, which immediately indicated two corrupt sectors.  I 
ran the Corrupt Sector Repair Utility (which does not seem to be 
documented in the manual that comes with DFT) after backing up, and 
repeated the tests a couple of times.  There were no more complaints 
from DFT.  I will be reloading my test directory, which I had to dump 
before the backup, and I will repeat the copy test on Monday after that 
to see if the file corruption still occurs.  

     I do not know what caused the corrupted sectors, but I am giving 
serious thought to a new mother board (to get rid of the chipset and 
Promise controller), and perhaps a replacement for the "IBM DeathStar". 
 I'll let you all know the outcome of the tests on Monday.  I am still 
curious about the precise 4k damaged blocks.






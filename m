Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265958AbRGKApi>; Tue, 10 Jul 2001 20:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266194AbRGKAp2>; Tue, 10 Jul 2001 20:45:28 -0400
Received: from node-cffb9242.powerinter.net ([207.251.146.66]:64251 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S265958AbRGKApP>; Tue, 10 Jul 2001 20:45:15 -0400
Message-ID: <3B4BA19C.3050706@switchmanagement.com>
Date: Tue, 10 Jul 2001 17:45:16 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2x Oracle slowdown from 2.2.16 to 2.4.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running 3 Oracle servers, each dual CPU, 1 1GB and 2 2GB memory, 
 between 36-180GB of RAID.  On June 26, I upgraded all boxes from Suse 
7.0 to Suse 7.2 (going from kernel version 2.2.16-40 to 2.4.4-14). 
 Reviewing Oracle job times (jobs range from a few minutes to 10 hours) 
before and after, performance is almost exactly twice as poor after the 
upgrade versus before the upgrade.  Nothing in the hardware or Oracle 
configuration has changed on any server.  Does anyone have any ideas as 
to what might cause this?

Thanks,
Brian Strand
CTO Switch Management



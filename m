Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWDHTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWDHTyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWDHTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 15:54:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:136 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751419AbWDHTyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 15:54:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <443814AA.1040707@s5r6.in-berlin.de>
Date: Sat, 08 Apr 2006 21:53:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dan Dennedy <dan@dennedy.org>
CC: linux1394-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       scjody@modernduck.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
References: <20060406224706.GD7118@stusta.de> <44374FC0.3070507@s5r6.in-berlin.de> <200604081218.24544.dan@dennedy.org> <443813C4.9090000@s5r6.in-berlin.de>
In-Reply-To: <443813C4.9090000@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.768) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dan Dennedy wrote:
>> Also, I have not released a version of libraw1394 that contains the 
>> deprecation warnings, but I can do so this weekend. And then another 
>> release when the removed kernel interfaces are released that removes 
>> the functions. 

We should have added such warnings already to the kernel at the moment 
when the two ioctls went into feature-removal-schedule.txt.
-- 
Stefan Richter
-=====-=-==- -=-- -=---
http://arcgraph.de/sr/

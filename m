Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUFWO0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUFWO0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUFWO0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:26:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:64517 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265210AbUFWO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:26:51 -0400
Message-ID: <40D9979E.5020709@techsource.com>
Date: Wed, 23 Jun 2004 10:45:50 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG?:   G5 not using all available memory -- SOLVED
References: <1087858881.22687.36.camel@gaston> <40D850C5.1080802@nortelnetworks.com>
In-Reply-To: <40D850C5.1080802@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Friesen wrote:
> 
> Well, I went and opened the case.
> 
> Lo and behold the bottom bank had three DIMMs while the top bank had 
> only one. Not sure if it came like that or if someone messed with it. I 
> moved one of the DIMMs to even it out, and sure enough its showing up 
> with the full amount now.
> 
> Sorry to bother you all...
> 


This isn't all too uncommon.  I've seen this in Sun workstations that 
just got delivered directly from Sun.


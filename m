Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUBFTEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUBFTEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:04:11 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:60855
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265640AbUBFTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:04:06 -0500
Message-ID: <4023E5AB.7070502@tmr.com>
Date: Fri, 06 Feb 2004 14:06:19 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: cdwriter /dev/hdc question
References: <200402050825.58623.gene.heskett@verizon.net>
In-Reply-To: <200402050825.58623.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> Running 2.6.2 atm, but for quite a while in the 2.6.x series I've had 
> a line in /var/log/messages immediately after the dmesg dump 
> indicating that dma was being disabled for /dev/hdc.

I think this is bogus, in that it is silently enabled again. Ask hdparm!

I thought that message was either going to go away or be paired with a 
similar "I didn't mean it" message if the drive is reenabled, but I 
can't quickly find the discussion.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

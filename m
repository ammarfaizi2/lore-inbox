Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDMQVa>; Fri, 13 Apr 2001 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDMQVU>; Fri, 13 Apr 2001 12:21:20 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:25104 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131481AbRDMQVI> convert rfc822-to-8bit; Fri, 13 Apr 2001 12:21:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Date: Fri, 13 Apr 2001 18:28:20 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041317365500.00665@debian> <20010413090751.E4557@greenhydrant.com>
In-Reply-To: <20010413090751.E4557@greenhydrant.com>
MIME-Version: 1.0
Message-Id: <01041318282003.00665@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. April 2001 18:07 schrieb David Rees:

> Cconfig and setup looks OK.
>
> What happens if your run hdparm -t /dev/hda and /dev/hdc at the same time?

Good idea!
The performance is only ~11MB/sec per disk
There is a bottleneck somewhere...

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVDHQbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVDHQbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVDHQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:31:37 -0400
Received: from s14.s14avahost.net ([66.98.146.55]:1453 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S262870AbVDHQbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:31:31 -0400
Message-ID: <4256B1D2.5080502@katalix.com>
Date: Fri, 08 Apr 2005 17:31:14 +0100
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ladislav Michl <ladis@linux-mips.org>
CC: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH] ds1337 1/4
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique> <20050407233628.GA6703@kroah.com> <20050408130021.GA7054@orphique>
In-Reply-To: <20050408130021.GA7054@orphique>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: jchapman@katalix.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for joining this thread late.

Patches 1-3 are fine with me.

/james

Ladislav Michl wrote:

> On Thu, Apr 07, 2005 at 04:36:29PM -0700, Greg KH wrote:
> 
>>Oops, you forgot to add a Signed-off-by: line for every patch, as per
>>Documentation/SubmittingPatches.  Care to redo them?
> 
> 
> Here it is (I'm sorry about that).
> 
> Use i2c_transfer to send message, so we get proper bus locking.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 

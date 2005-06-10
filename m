Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFJVBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFJVBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFJVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:01:00 -0400
Received: from [85.8.12.41] ([85.8.12.41]:23733 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261174AbVFJVAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:00:44 -0400
Message-ID: <42A9FF79.1010003@drzeus.cx>
Date: Fri, 10 Jun 2005 23:00:41 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: MMC ioctl or sysfs interface?
References: <42A83F59.7090509@drzeus.cx> <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
In-Reply-To: <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Thu, Jun 09, 2005 at 03:08:41PM +0200, Pierre Ossman wrote:
>
>  
>
>>MMC cards have the feature to lock down cards using a special
>>password.  When the cards is locked it will not accept any commands
>>except lock-related ones.
>>    
>>
>
>IDE disks can do this too --- is it the same interface?
>  
>

No. ATA and MMC are very different protocols.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268116AbUHXQ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268116AbUHXQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUHXQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:59:22 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:34704 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268116AbUHXQ7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:59:17 -0400
Message-ID: <412B73D5.60303@drzeus.cx>
Date: Tue, 24 Aug 2004 18:59:01 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <412B6FD6.2050105@drzeus.cx> <20040824174642.G7738@flint.arm.linux.org.uk>
In-Reply-To: <20040824174642.G7738@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Tue, Aug 24, 2004 at 06:41:58PM +0200, Pierre Ossman wrote:
>  
>
>>The MMC patches included in 2.6.9-rc1 missed drivers/Kconfig.
>>    
>>
>
>Not really.  The presently supported MMC interfaces only exist on ARM,
>and ARM doesn't use drivers/Kconfig.
>
>  
>
Ok, didn't know that.
Could it be added anyway? I'm writing a driver for a PC based SD/MMC 
card reader that relies on the routines. Would save me the trouble of 
having a patch for just the Kconfig. :)


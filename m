Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUHYL2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUHYL2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 07:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHYL2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 07:28:52 -0400
Received: from mail.timesys.com ([65.117.135.102]:7459 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266890AbUHYL2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 07:28:35 -0400
Message-ID: <412C77E2.1000702@timesys.com>
Date: Wed, 25 Aug 2004 07:28:34 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: [patch] ppc ep8260 support under 2.6.6
References: <412B638E.80500@timesys.com> <20040824213035.GH4521@smtp.west.cox.net>
In-Reply-To: <20040824213035.GH4521@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Aug 2004 11:26:40.0671 (UTC) FILETIME=[645C3AF0:01C48A96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>On Tue, Aug 24, 2004 at 11:49:34AM -0400, Greg Weeks wrote:
>
>  
>
>>This is basic support for the Embedded Planet's ep8260 board. It doesn't 
>>include MTD support. This patch unfortunatly doesn't apply to 2.6.8 just 
>>to 2.6.6. The code isn't mine, though it was developed here at Timesys. 
>>I just needed it running under 2.6.6.
>>
>>Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0057
>>    
>>
>
>Note the reason it doesn't apply is that ep8260 (rpx8260) went into
>2.6.8. :)
>
>  
>
That's even better. :)

>If you have access to the board, could you give it a shot in the
>linuxppc-2.5 tree?  There's fcc changes in there that I'd like to get
>tested on a few more boards before I push them out (or the driver gets
>obsoleted).
>
>  
>
Unfortunately I don't have bitkeeper access. Is there a tar ball of the 
ppc tree? I didn't find one the last time I went looking.

Greg Weeks

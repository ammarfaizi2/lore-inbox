Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUATPjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUATPia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:38:30 -0500
Received: from mail.ccur.com ([208.248.32.212]:29702 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265583AbUATPhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:37:24 -0500
Date: Tue, 20 Jan 2004 10:36:55 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
Message-ID: <20040120153655.GA18483@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117183929.GA24185@tsunami.ccur.com> <400C4966.2030803@us.ibm.com> <20040120035756.GA15703@tsunami.ccur.com> <400CD2CF.6030506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CD2CF.6030506@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>However, IMHO you added too many comments.  Unlike Andrew, I do believe
>>one can have too many comments.  Comments become 'too many' when they
>>dilute to the point that the code can no longer be clearly read.
>>
>>If you reduce the comments to just those that say something not easily
>>deduced from the code, then they would be acceptable to me, and would
>>make a useful addition IMO.  That would be all but three, or perhaps four,
>>of them.
>>
>>Andrew, if you do like the fully commented version, then please remove
>>my name from the comment in the patch.  The dilute style of coding is
>>not one I wish to have my name associated with.
>>
>>Thanks,
>>Joe
> 
> I'm sorry you feel that way, Joe.  I had no intention of "diluting" your 
> code, and I certainly don't want you to remove your name from good code 
> you spent significant time & effort on.  I'm just about to go to sleep, 
> so I made this patch pretty quickly.  I think the 4 comments I kept are 
> the most useful and non-obvious.  Let me know if this looks acceptable 
> to you.  As I said, I have no desire to have you pull your name from the 
> code, especially since I feel it is good code!
> 
> Andrew, once Joe and I work out an acceptable patch, we'll make sure you 
> get a copy.

Much better, Matthew.  I can live with this latest patch:)
Thanks,
Joe

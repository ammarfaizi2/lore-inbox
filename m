Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUBBRL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUBBRL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:11:59 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:55557 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265754AbUBBRL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:11:57 -0500
Message-ID: <401E85EA.7010209@techsource.com>
Date: Mon, 02 Feb 2004 12:16:26 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: DaMouse Networks <damouse@ntlworld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] Crazy idea: Design open-source graphics chip
References: <20040201145827.059332d3@EozVul.WORKGROUP>
In-Reply-To: <20040201145827.059332d3@EozVul.WORKGROUP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



DaMouse Networks wrote:
>>A cheap cludge would be an optional second GPU on the card just to do
>>the required VGA modes, with an analogue video pass-through. That
>>would make the VGA cards more expensive than a single GPU which
>>incorporated VGA, but add almost nothing in cost or complexity terms
>>to the non-VGA cards.
> 
> 
> I was thinking of suggesting something similar as I browsed the thread. I would think that having Linux instead of the BIOS would be good since you would only need a small cut-down Linux that has drivers for a VGA->FB interface or something similar. The SMP approach from XGI might work in this since Linux supports SMP very well and  it could perform well with up to like 4+ GPUs? (thinking of the card size that might limit this you could have them stacked :) )
> 
> I think I'm gonna have to follow this thread closely :)


So, do you all honestly think that adding cost to the board is going to 
make it sell?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264921AbUEYPUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUEYPUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEYPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:20:22 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:45203 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S264921AbUEYPTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:19:52 -0400
Message-ID: <40B3642C.3070504@timesys.com>
Date: Tue, 25 May 2004 11:20:12 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <Pine.LNX.4.58.0405231159240.512@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0405231218110.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405231218110.25502@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 23 May 2004, Davide Libenzi wrote:
>  
>
>>Andrew already puts the "From:" thing in the patch comment, so this should 
>>be simply a matter of replacing "From:" with "Signed-off-by:", preserving 
>>it in logs, and documenting the thing in the patch submission doc. No?
>>    
>>
>
>Yes and no.
>
>Right now it is _Andrew_ that does the From: line from you. In the 
>sign-off procedure, it would be _you_ who add the "Signed-off-by:" line 
>for yourself.
>
>(And then Andrew would sign off on the fact that you signed off).
>
>Not a big difference, I agree. 
>  
>
Andrew's From comment is already a little lossy, e.g. most LKSCTP patches
show up as from Sridhar or DaveM even though there's a whole subproject
of developers working behind Sridhar.

I think the proposed process will increase the amount of explicit credit
being recognized--a very good thing IMHO, since this is the core currency
of our gift culture.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig


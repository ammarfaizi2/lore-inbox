Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJaOPe>; Thu, 31 Oct 2002 09:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSJaOPe>; Thu, 31 Oct 2002 09:15:34 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2755 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262197AbSJaOPd>; Thu, 31 Oct 2002 09:15:33 -0500
Message-ID: <3DC13C6F.3000405@nortelnetworks.com>
Date: Thu, 31 Oct 2002 09:21:35 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>>Linux Trace Toolkit (LTT
> I don't know what this buys us.

I'd like to add a request for this to be in mainstream.  The benefits 
have already been stated in this thread, and it has been used here to 
good effect.

>>Crash Dumping (LKCD
> This is definitely a vendor-driven thing. I don't believe it has any 
> relevance unless vendors actively support it.

I'd like to see this too.  The more debug information the better as far 
as I'm concerned.


>>Hires Timer
> This one is likely another "vendor push" thing.

It doesn't hurt performance when turned off, and allows for 
finer-grained timing when turned on.  What's not to like?  I can't 
comment on the actual code, but I really like the idea.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


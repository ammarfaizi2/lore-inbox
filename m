Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272352AbRHYASq>; Fri, 24 Aug 2001 20:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272353AbRHYASg>; Fri, 24 Aug 2001 20:18:36 -0400
Received: from web10906.mail.yahoo.com ([216.136.131.42]:60687 "HELO
	web10906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272352AbRHYAS3>; Fri, 24 Aug 2001 20:18:29 -0400
Message-ID: <20010825001844.15318.qmail@web10906.mail.yahoo.com>
Date: Fri, 24 Aug 2001 17:18:44 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010824.170748.41633430.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Brad Chapman <kakadu_croc@yahoo.com>
>    Date: Fri, 24 Aug 2001 16:59:27 -0700 (PDT)
>    
>    	- stay with the old-style macros (:P, :P, :P)
> 
> I've been trying to stay out of this until Linus returns
> and has his word... but I can say with a level of certainty
> that this won't sit well with Linus at all.
> 
> Later,
> David S. Miller
> davem@redhat.com

Mr. Miller,

	Ack. When Linus returns, I'm sure he'll give us all very good reasons 
why he thought it needed to be changed.

	BTW, what is your opinion on the various ways I suggested to satisfy 
people over the min()/max() issue? Mr. LaHaise nearly threw up when I suggested 
using #ifdef, so we can safely scratch that one ;-). What do you think, sir?

Brad 


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

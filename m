Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135488AbRAYTwn>; Thu, 25 Jan 2001 14:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133078AbRAYTwd>; Thu, 25 Jan 2001 14:52:33 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:55047 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S129274AbRAYTwZ>;
	Thu, 25 Jan 2001 14:52:25 -0500
Date: Thu, 25 Jan 2001 11:52:14 -0800
From: alex@foogod.com
To: "David S. Miller" <davem@redhat.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010125115214.D9992@draco.foogod.com>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14960.31423.938042.486045@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 11:13:03AM -0800, David S. Miller wrote:
> 
> Albert D. Cahalan writes:
>  > How about some way to test before you do this?
>  > Example: an ecn.kernel.org host that replys to mail.
> 
> "test"?  I know exactly whats going to happen, and unless folks like
> hotmail.com and others get their act together I'll certainly end up
> removing *@*hotmail.com from the lists by the end of that day.
> 
> That is the whole point of this experiment.

I think the point of a test address is that this could conceivably 
affect more providers than just Hotmail, and it would be useful for people to 
be able to check to make sure their own provider isn't also ECN brain damaged 
so they can yell at them and maybe get the problem fixed  before it happens
instead of just suddenly not getting list mail one day..

Regarding Hotmail.. has anybody actually tried informing them that Cisco has a 
stable patch available?  It's possible they're just misinformed about its 
status.  I do think they should at least be given credit for:

1) Actually responding to inquiries about the issue.
2) Understanding what the issue is.
3) Apparently already being aware that a problem exists, if perhaps mistaken 
   about solutions available.

I have to say that in my experience, this is a helluva lot more on the ball 
than what you'd get from most places, and indicates to me that there may be 
hope yet for getting this fixed.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

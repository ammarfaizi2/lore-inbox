Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277493AbRJEQsY>; Fri, 5 Oct 2001 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277494AbRJEQsP>; Fri, 5 Oct 2001 12:48:15 -0400
Received: from mail.nep.net ([12.23.44.24]:60934 "HELO nep.net")
	by vger.kernel.org with SMTP id <S277493AbRJEQsC>;
	Fri, 5 Oct 2001 12:48:02 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A038B63@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: Larry McVoy <lm@bitmover.com>,
        "Alan Cox (E-mail)" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 3ware discontinuing the Escalade Series
Date: Fri, 5 Oct 2001 12:49:19 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laary,

The Adaptec 2400A IDE Raid Cards work under Linux, although you will need to
patch your kernel, the patch is available from Adaptec's website. 
It seems like work was being done to add support for the Promise RAID cards,
it seems like Alan had support in his tree, I might be wrong about that
though. Alan?

Ryan

> -----Original Message-----
> From: Larry McVoy [mailto:lm@bitmover.com]
> Sent: Friday, October 05, 2001 12:10 PM
> To: Jason Giglio
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 3ware discontinuing the Escalade Series
> 
> 
> On Thu, Oct 04, 2001 at 02:19:42PM -0400, Jason Giglio wrote:
> > 3ware has decided to discontinue their escalade series IDE 
> RAID controller
> > cards.  The drivers were open source and in the kernel tree.
> 
> OK, this sucks because I like those cards a lot.  Before I go out and
> stock up on a bunch of them, is there anything else out there 
> that works
> as well and is supported by Linux?
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           
> http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

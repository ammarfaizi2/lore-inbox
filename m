Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131847AbRAXAT0>; Tue, 23 Jan 2001 19:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131955AbRAXATQ>; Tue, 23 Jan 2001 19:19:16 -0500
Received: from web118.mail.yahoo.com ([205.180.60.99]:32010 "HELO
	web118.yahoomail.com") by vger.kernel.org with SMTP
	id <S131847AbRAXATK>; Tue, 23 Jan 2001 19:19:10 -0500
Message-ID: <20010124001908.21248.qmail@web118.yahoomail.com>
Date: Tue, 23 Jan 2001 16:19:08 -0800 (PST)
From: Cacophonix <cacophonix@yahoo.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://community.roxen.com/developers/idocs/drafts/draft-minshall-nagle-01.txt

There's also a paper on the specific issues:
http://www.cc.gatech.edu/fac/Ellen.Zegura/wisp99/papers/minshall.ps

You may also want to look up the ietf tcp-impl archive from '99 for discussions
on the draft.

cheers,
karthik


--- Guus Sliepen (guus@warande3094.warande.uu.nl) wrote:

On Sat, Jan 20, 2001 at 10:39:36PM +0300, Alexey Kuznetsov wrote: 

> Yes. It is cost, which we have to pay. Look into Minshall's draft, 
> by the way (draft-minshall-nagle-*), it discusses pros and contras. 

What kind of draft is that? I can't find it on the IETF site. Could you 
provide me with a link? 

------------------------------------------- 
Met vriendelijke groet / with kind regards, 
  Guus Sliepen <guus@sliepen.warande.net> 
------------------------------------------- 

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

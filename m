Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136688AbREASOn>; Tue, 1 May 2001 14:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136683AbREASOc>; Tue, 1 May 2001 14:14:32 -0400
Received: from c1123685-a.crvlls1.or.home.com ([65.12.164.15]:12049 "EHLO
	inbetween.blorf.net") by vger.kernel.org with ESMTP
	id <S136687AbREASOX>; Tue, 1 May 2001 14:14:23 -0400
Date: Tue, 1 May 2001 11:14:13 -0700 (PDT)
From: Jacob Luna Lundberg <kernel@gnifty.net>
Reply-To: jacob@chaos2.org
To: Ronny Haryanto <ronny-linux@haryan.to>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver broken in 2.4.4?
In-Reply-To: <20010501125721.A1734@haryan.to>
Message-ID: <Pine.LNX.4.21.0105011108500.2956-100000@inbetween.blorf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I guess I should chip in here with the rather amusing fact that
2.4.4 is the first kernel *not* to do this to me...  ;-)

I am, of course, glad to help out testing stuff if needed.  My card is
also a LinkSys LNE100TX v4.1, which the tulip driver identifies as an
ADMtek Comet rev 17 (although somebody told me it's really a Centaur).

-Jacob

On Tue, 1 May 2001, Ronny Haryanto wrote:
> On 01-May-2001, Jeff Garzik wrote:
> > Ronny Haryanto wrote:
> > > 
> > > Just tried 2.4.4 yesterday and found that my eth1 was dead after 5 minutes.
> > 
> > Does 2.4.3 work for you?
> 
> Yes. I just tried 2.4.3, and it works fine. So it looks like there's a bug
> introduced between 2.4.3 and 2.4.4. Too bad I can't use 2.4.3; I need 2.4.4
> due to the VIA chipset bug. Is there any other info that I could provide
> from here to help debugging?



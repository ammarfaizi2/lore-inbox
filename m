Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDHGUs>; Sun, 8 Apr 2001 02:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDHGUi>; Sun, 8 Apr 2001 02:20:38 -0400
Received: from vitelus.com ([64.81.36.147]:2564 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S132516AbRDHGUZ>;
	Sun, 8 Apr 2001 02:20:25 -0400
Date: Sat, 7 Apr 2001 23:19:56 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Michael Peddemors <michael@linuxmagic.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: goodbye
Message-ID: <20010407231956.A344@vitelus.com>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <20010404012102Z131724-406+7418@vger.kernel.org> <20010408023228.L805@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010408023228.L805@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Sun, Apr 08, 2001 at 02:32:28AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 02:32:28AM +0300, Matti Aarnio wrote:
> 	The incentive behind the DUL is to force users not to post
> 	straight out to the world, but to use their ISP's servers
> 	for outbound email --- normal M$ users do that, after all.
> 	Only spammers - and UNIX powerusers - want to post directly
> 	to the world from dialups.  And UNIX powerusers should know
> 	better, and be able to use ISP relay service anyway.

Personally, this concerns me.

I have a personal mailserver on my DSL line. Now, DSL isn't dialup,
but it's quite widespread and I'm sure it's even more popular among
spammers than the mass market. The doomsday scenario is that one day
all messages messages will have to be relayed through Hotmail, Yahoo,
or another one of a handful of large, untrustworthy corporations. Of
course I know this isn't likely, but what's to prevent people who
can't afford T1's from becoming unable to run mail servers?

It scares me that peoples' messages would be denied based on what
degree of connection they choose to mail via. I sincerely hope that
the DUL lists only list netblocks that are actively being used for
spam. This would be sort of like the Usenet Death Penalty, instating
bans on providers who refuse to deal with spamming. I think that's a
lot more acceptable than shutting everyone who happens to connect to
the internet in a certain way from sending mail directly out of their
local machines.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267769AbTADBT3>; Fri, 3 Jan 2003 20:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbTADBT3>; Fri, 3 Jan 2003 20:19:29 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:7105 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267769AbTADBT0>; Fri, 3 Jan 2003 20:19:26 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Andrew Walrond <andrew@walrond.org>, Larry McVoy <lm@bitmover.com>,
       Samuel Flory <sflory@rackable.com>,
       David Schwartz <davids@webmaster.com>, Marco Monteiro <masm@acm.org>,
       linux-kernel@vger.kernel.org
Date: Fri, 3 Jan 2003 17:15:23 -0800 (PST)
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <20030104013011.GC4472@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0301031712100.23270-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if the server is just a comm relay this is true, but if the server
implements real game logic then it's much less of a problem (show me the
copycat everquest servers for example)

as for validating license keys, if you want that to happen you have to
make the validation code public (which is possible if you use the right
algorithm)

David Lang


 On Fri, 3 Jan 2003, Mark Mielke wrote:

> Date: Fri, 3 Jan 2003 20:30:11 -0500
> From: Mark Mielke <mark@mark.mielke.cc>
> To: Andrew Walrond <andrew@walrond.org>
> Cc: Larry McVoy <lm@bitmover.com>, Samuel Flory <sflory@rackable.com>,
>      David Schwartz <davids@webmaster.com>, Marco Monteiro <masm@acm.org>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Why is Nvidia given GPL'd code to use in closed source
>     drivers?
>
> On Fri, Jan 03, 2003 at 10:55:13PM +0000, Andrew Walrond wrote:
> > Of course I and probably many others are moving to a new model for our
> > games. I'm probably being more radical than most; Open Source client
> > software. Useless of course without a connection to my server side code :)
> > It's the first game I've produced that is pirate proof.
>
> If the game is good enough, it isn't pirate proof. I believe that Blizzard
> and other such companies have pursued this course in the past. The result?
> The hackers watch the communication between the client and the server and
> write their own servers. They even go so far as to pretend as if the practice
> is legal by putting disclaimers on the "public servers" that state that
> "you may only connect to this service if you have purchased a valid license
> for this game." Of course, they don't verify license keys...
>
> mark
>
> --
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   |
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada
>
>   One ring to rule them all, one ring to find them, one ring to bring them all
>                        and in the darkness bind them...
>
>                            http://mark.mielke.cc/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

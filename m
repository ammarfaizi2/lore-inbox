Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSIPCI1>; Sun, 15 Sep 2002 22:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318630AbSIPCI0>; Sun, 15 Sep 2002 22:08:26 -0400
Received: from bitmover.com ([192.132.92.2]:37808 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S318614AbSIPCI0>;
	Sun, 15 Sep 2002 22:08:26 -0400
Date: Sun, 15 Sep 2002 19:13:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915191318.C22354@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <E17qRfU-0001qz-00@starship> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <20020915190435.GA19821@nevyn.them.org> <20020915162412.A17345@work.bitmover.com> <20020915234108.GA1348@nevyn.them.org> <20020915165235.B17345@work.bitmover.com> <1032139750.26911.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032139750.26911.20.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 16, 2002 at 02:29:10AM +0100
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 02:29:10AM +0100, Alan Cox wrote:
> On Mon, 2002-09-16 at 00:52, Larry McVoy wrote:
> > If your company has such a poor business model that they can't afford to
> > pay you enough to take the time to do a good job then find a different
> > place to work.  No amount of debugger "help" is going to make up for a
> > lack of understanding.
> 
> Maybe he works at a company with a good enough business model to realise
> that people who can't or won't use tools for pet high horse reasons are
> ineffeciencies that are best "downsized" either in ego or personnel
> count.

You are completely missing the point.  I explictly stated that debuggers
are just fine with me, I don't really care one way or the other.  I also
stated that I use debuggers and I'm OK with other people using them as
well.  Where's the "won't use tools for pet high horse reasons"?  Nowhere.

My comments, which I stand behind now and will stand behind 10 years
from now, are based on the fact that people who don't understand the
code shouldn't be modifying the code.  If a debugger helps you understand
the code, go for it.  However, my experience is that what he was saying
resonates with "I'm going in to fix this problem so I can get back to
work on my real project".  And that is almost always wrong.  If the
problem was that bloody simple don't you think the original author of
the code would have fixed it already?  It's almost never as simple as a
naive point of view thinks it is and that's exactly why you don't want
people hacking about in that code.  Either understand it and really fix
it, own it, maintain it, live with it, or leave it alone.  

You may have a different opinion, Alan, and that's fine.  All that
means is that you won't ever work here.  One of the nice things about
being the guy who runs the company is that you get to insist on a certain
level of competence and professionalism or you're fired.  It's one of
the reasons I don't work for someone else, I like being able to say
"do it right or don't do it, I pay the bills, that's what I want".
I learned that at Sun, over my every objection because I was an idiot,
but I learned it.  After you learn the benefits of doing things right
you have nothing but pity for people who do it wrong.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

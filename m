Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbSJGXWl>; Mon, 7 Oct 2002 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263166AbSJGXWl>; Mon, 7 Oct 2002 19:22:41 -0400
Received: from web13205.mail.yahoo.com ([216.136.174.190]:36103 "HELO
	web13205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262746AbSJGXWj>; Mon, 7 Oct 2002 19:22:39 -0400
Message-ID: <20021007232818.80269.qmail@web13205.mail.yahoo.com>
Date: Mon, 7 Oct 2002 16:28:18 -0700 (PDT)
From: Gigi Duru <giduru@yahoo.com>
Subject: Re: The end of embedded Linux?
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021005205847.GA1493@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a bug report, not a feature request ;)

--- Mark Mielke <mark@mark.mielke.cc> wrote:
> You could always try examining the code for yourself
> and making a
> suggestion regarding inappropriate dependencies, or
> bloated
> dependencies. One of the problems you have here
> is... Linux 'hackers'
> are not trying to sell you an embedded solution. If
> anything, you
> are getting a freebie, and you should be gracious
> that you don't
> have to pay full price for a commercial solution...
> 
> Other members of the 'hacker computer' who work for
> companies that use
> Linux in their embedded product tend not to scream
> and complain. Instead,
> they roll up their sleeves and get to it...
> 
> One of the methods described above has a better
> chance of being effective.
> 
> Which one do you think that might be? :-)
> 
> mark
> 
> P.S. Linux 2.5 is a development kernel - the fact
> that is isn't polished
>      to your liking is not a surprise. It isn't
> polished to *many* peoples
>      likings, which is the primary reason that
> people such as myself have
>      not installed it.
> 
> 
> On Sat, Oct 05, 2002 at 01:52:38PM -0700, Gigi Duru
> wrote:
> > Now thats some advice from a kernel hacker... You
> > really don't seem to care too much about embedded,
> do
> > you? 
> > 
> > It's not about what I do not do, it's about what
> YOU
> > do (I'm not talking to you personally, but to the
> > hacker community as a whole). The kernel core
> didn't
> > jump to 270KB compressed because I didn't do
> > something.
> > 
> > Let me reformulate for you:
> > * some years ago, (2.2 era) I was more than happy
> > about embedding Linux.
> > * along came 2.4, and things got fuzzy (should we
> move
> > on, or stick to the good ol' stuff?)
> > * now, 2.6 (or whatever) seems like a very bad
> choice
> > for us.
> > * I wonder about the next one (2.8/whatever): will
> it
> > require a mainframe to run?
> > 
> > It's the trend, you see: you were on the right
> track
> > but now you're loosing it. From the embedded point
> of
> > view, YOU ARE GOING THE WRONG DIRECTION.
> > 
> > And don't give me the "use 2.2" advice. Stuff is
> being
> > back-ported, I know, but not all of it. 
> > 
> > Why are old versions being actively maintained
> anyway?
> > Isn't that a realization that those old versions
> are
> > better suited for some tasks than the new one? Why
> > would anyone choose to use 2.2? Because it serves
> him
> > better. 
> > 
> > Now, why is 2.2 serving someone better than 2.4?
> > That's something I'd like you to answer...
> > 
> > The beauty of Linux was it's scalability (I'm not
> > talking SMP here): you had the same kernel running
> on
> > the appliance, on the PC and on that mainframe.
> Things
> > were smooth, things were perfect. I would have
> loved
> > to preserve that...
> > 
> > Regards,
> > Gigi 
> > 
> > --- Andre Hedrick <andre@linux-ide.org> wrote:
> > > 
> > > Well have a nice day and go pay for windriver
> > > licenses, or use the source
> > > to adopt to your needs, or hire somebody who can
> do
> > > it for you.
> > > Whinning will not help, doing will.
> > > 
> > > Regards,
> > > 
> > > Andre Hedrick
> > > LAD Storage Consulting Group
> > > 
> > 
> > __________________________________________________
> > Do you Yahoo!?
> > Faith Hill - Exclusive Performances, Videos & More
> > http://faith.yahoo.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com
> __________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__ 
> | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_  
> | 
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__ 
> | Ottawa, Ontario, Canada
> 
>   One ring to rule them all, one ring to find them,
> one ring to bring them all
>                        and in the darkness bind
> them...
> 
>                            http://mark.mielke.cc/
> 


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com

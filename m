Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286899AbSABKPF>; Wed, 2 Jan 2002 05:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286909AbSABKOp>; Wed, 2 Jan 2002 05:14:45 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:51726 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286907AbSABKOn>;
	Wed, 2 Jan 2002 05:14:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: The direction linux is taking
Date: Wed, 2 Jan 2002 11:14:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <E16Ky48-0003hT-00@starship.berlin> <20020101053446.HLQO11986.femail30.sdc1.sfba.home.com@there>
In-Reply-To: <20020101053446.HLQO11986.femail30.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16LiPl-00010E-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 31, 2001 10:33 pm, Rob Landley wrote:
> On Monday 31 December 2001 03:45 am, Daniel Phillips wrote:
> > On December 29, 2001 11:04 pm, Larry McVoy wrote:
> > > On Sat, Dec 29, 2001 at 04:03:34PM -0500, Benjamin LaHaise wrote:
> > > > On Sat, Dec 29, 2001 at 11:37:49AM -0800, Larry McVoy wrote:
> > > > > If you have N people trying to patch the same file, you'll require N
> > > > > releases and some poor shlep is going to have to resubmit their patch
> > > > > N-1 times before it gets in.
> > > >
> > > > Wrong.  Most patches are independant, and even touch different
> > > > functions.
> > >
> > > Really?  And the data which shows this absolute statement to be true is
> > > where?  I'm happy to believe data, but there is no data here.
> >
> > Ben's right.  Most patches are independant because the work divides itself
> > up that way, because people talk about this stuff (on IRC) and cooperate,
> > and because the tree structure evolves to support the natural divisions ;)
> 
> In a fan club, saying "andrea's the MM guy, talk to him" is only natural.  
> It's a meritocracy, he's alpha geek on call in that area right now.
> 
> In a fortune 500 bureaucracy, people are largely supposed to be 
> interchangeable cogs.  People's worth is measured in dollars, and somebody 
> worth $70k a year should be swappable with somebody else worth $70k/year.  
> (It's a bit more complex than that, there's certifications and experience, 
> but somebody with a BA and 2 years experience working on inflatable widgets 
> should be exchangeable with somebody else with a BA and 2 years experience 
> working on inflatable widgets.  If not, they'll "get up to speed", it's just 
> a question of acquiring experience...)
> 
> So having a single point of failure in the development process...  It's 
> unthinkable.  What if that guy decides to retire?  What if he gets hit by a 
> bus.  What if the competition hires him away?  What if he DEMANDS MORE MONEY? 
>  (It's all about money in a corporation.  It's all numbers.  The bottom line. 
>  So if the whole project depends on one guy, logically he'll ask for as much 
> salary as the project's worth.  That's a lot of how management thinks.)
> 
> So if you DO have someone breaking down the project into subsections, it's 
> unlikely to be a developer, it would be a manager assigning areas of 
> responsibility.  And shuffling them around from time to time so nobody gets 
> the idea they can't be replaced.  But it's easiest just to scatter 
> tasks over the group and keep things mixed up all the time...
> 
> Fan clubs are all individuals.  Bureaucracies try to eliminate the 
> individual: the automated assembly line with no humans in it is the 
> bureaucratic ideal...
> 
> Totally different paradigm.

Yes, that's all +5 insightful, except... what makes you think any one of the 
Linux core hackers is irreplaceable?  I know you didn't say that, but you
did say 'single point of failure', and it amounts to the same thing.

--
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTAEWU5>; Sun, 5 Jan 2003 17:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTAEWU5>; Sun, 5 Jan 2003 17:20:57 -0500
Received: from auto-matic.ca ([216.209.85.42]:19729 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265306AbTAEWUz>;
	Sun, 5 Jan 2003 17:20:55 -0500
Date: Sun, 5 Jan 2003 17:37:53 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Graham Murray <graham@barnowl.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Message-ID: <20030105223753.GC31840@mark.mielke.cc>
References: <m3isx3lmkt.fsf@home.gmurray.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3isx3lmkt.fsf@home.gmurray.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 02:04:34PM +0000, Graham Murray wrote:
> David Schwartz <davids@webmaster.com> writes:
> > Fine, keep the drivers closed source. Just tell us what the
> > interfaces are and we'll make our own drivers. Maybe they're afraid
> > ours will be better. ;)
> Which could be of (commercial) benefit to them, as if the Open Source
> drivers were better than their own they could save money by not
> developing and supporting drivers and distributing the open source
> drivers.

Especially in the case of hardware, one of the primary reasons I suspect
companies to resist open source drivers is 'risk'.

Scenario: I invent some sort of fancy hardware that does some
incredible thing. Companies all over the world love my hardware, and
they install it on all of their computers. I use the profit to fund
more research, development, expanding my company into other areas, and
of course, some of the profit goes to the stock holders. My customers
want my hardware to work on Linux. I say hmm... well... it will only
cost 4 full-time people resources to do this... and I can even let them
do Linux development on the side when they aren't busy as a method of
letting my company be more popular in the open source community.

Then one day the suggestion is made to me -- why hire 4 full-time
people resources, when you can hire only one, release the code as open
source, and let the community manage it?

I think about it for a while. What could I possibly lose?

I do it. Open sourced drivers, YEAH! Cheaper for me, the customers love
it, and I even get free features that I didn't even think about.

Then one day - everybody upgrades to a new version of Linux. My
support lines start ringing off the hook. The thing doesn't work in
the new version of Linux! I plead with the open source community to
complete the work, but for some reason, these people are on vacation,
or want to be working on something else! Nobody is responsible for the
source code, and I can't do anything about it! I quickly make a plea
to a wider community "anybody have good references and can work on
this project ASAP for a very decent sum of money?" Finally, a week
later, the details are sorted out, and development begins. My
customers are mad. I have no control of the situation.

What is this head-ache worth?

I made this scenario up. It might have no bases on reality. However -
companies don't always fear only the scenarios that could happen. The
fear what shouldn't happen, that they cannot control. They have
to. They have thousands of stock holders who will have their neck if
they fail.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274784AbRJAIsF>; Mon, 1 Oct 2001 04:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274777AbRJAIr4>; Mon, 1 Oct 2001 04:47:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:31502 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274784AbRJAIrw>; Mon, 1 Oct 2001 04:47:52 -0400
Message-ID: <3BB82DA9.34499802@idb.hist.no>
Date: Mon, 01 Oct 2001 10:47:37 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] New Anti-Terrorism Law makes "hacking" punishable by life in 
 prison
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBIENPDNAA.znmeb@aracnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward Borasky" wrote:
> 
> While I don't want to get involved in a comparison between the loss of some
> 7000 human lives in a terrorist attack on buildings with productivity lost
> due to Code Red and Nimda attacks on the world's businesses, I'd like to
> make two points:
> 
> 1. The losses to businesses from just these two virus attacks are
> *significant*, and people are angry about the fact. They're looking for
> someone to blame, 

And the one to blame here isn't the virus writer.  The ones to blame
are:
1. Whoever decided to install that vulnerable software.
   This one isn't popular because it is someone inside the company. 
   But that's where the problem is.  (Or possibly whoever hired
   a clueless admin.  Even less popular with the administration.)

   Someone trusted with important software ought to have the
   necessary skills.  Nobody let a clueless guy design
   _physical_ security for a bank...

2. Possibly the company making vulnerable software, although nobody
   sane should select that kind of software.  A bank don't use
   an array of piggy banks for a vault.  This is a question of 
   marketing - did they create the impression that their software
   was safe from trivial attacks?

Of course releasing a virus is bad, but we should still expect
companies to take some measures themselves.

We do expect them to lock doors etc. - Someone who leave
their office building _unlocked_ & unguarded, money in open drawers 
etc.  will usually not be able to collect insurance because of
obvious neglect.  They'll be laughed at, and nobody will cry
about more punishment for those who walks in and grabs some
stuff.


> 2. The Linux community should *not* believe that we are less vulnerable than
> Microsoft! We are less vulnerable *now* only because Linux is not as
> widespread as Windows. Were Linux, say, half of the market, the
> vulnerability would be equal. The difference is strictly the number of
> available hosts for these parasitic codes, not anything inherent in the
> details of Windows or Linux, or in the organizational mechanisms (corporate
> giant vs. "brutal meritocracy", closed source vs. open source, etc.).

Well, I believe Linux _is_ less vulnerable.  Not invulnerable of course,
but at least fixes appear a lot faster for linux.  That alone don't
usually leave enough timespan for a large-scale exploit.  
And I see many firewalls that really is a pc router running linux.
Are there any _serious_ ones running windows?


> In fact, I suspect that the open source for Linux gives creators of vicious
> attack codes a *slight* advantage, since the vulnerabilities are there for
> anyone to read and exploit before they are found by an alert Linux
> community. 

Many people read open source code looking for vulnerabilities.  Yeah,
some are exploiters.  But more of them are looking to plug the holes,
so this is a _big_ advantage for open source, not a _slight_ advantage
for crackers.  A hole only needs plugging _once_ before nobody can use
it.

And the people capable of finding a hole by looking at source will
usually report it - you can get more prestige that way than by
writing a exploit.  This boils down to who you want to impress - 
a bunch of stupid script kiddies or a bunch of security-minded
experts?  Some of the latter might even offer a paying job...

This don't work as well for closed source.  The bugs are harder to find,
but some are found anyway by disassembly or trial-and-error.  (What
happens
if I manufacture bad oversized input for this thing...)

What do you do about such a bug?  A patch is impossible without 
source.  Reports seems to go silently ignored.   A public report
might get you sued.  "You are out to get us & our customers,
and your license forbids hacking on it...."  People get bitter,
and gets incentives to make viruses.  It becomes the only
way of getting serious attention.

This incentive mostly goes away with open source, much more fun to
be among the "good guys" who stamps out bugs & get their names
immortalized in changelogs.

Helge Hafting

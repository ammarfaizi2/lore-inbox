Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286124AbRLaBEE>; Sun, 30 Dec 2001 20:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286123AbRLaBDz>; Sun, 30 Dec 2001 20:03:55 -0500
Received: from smtp02.iprimus.net.au ([203.134.65.99]:27142 "EHLO
	smtp02.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S286124AbRLaBDp>; Sun, 30 Dec 2001 20:03:45 -0500
Message-ID: <0c2501c19196$bab60ee0$4cac86cb@mharrop>
From: "Mark Harrop" <mharrop@iprimus.com.au>
To: "William Knop" <w_knop@hotmail.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <F112MFAONTUR4NQJyaL0000f6ad@hotmail.com>
Subject: Re: LKML signal to noise ratio-- improvement
Date: Mon, 31 Dec 2001 12:01:40 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 31 Dec 2001 01:03:37.0395 (UTC) FILETIME=[FA530030:01C19196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I appreciate you thinking along this line, but I think it won't work in the
long run..why ?

What I have noticed on other lists where there a -general, -devel, etc., is
that people end up cc'ing to the other lists, and people who are on all list
get everything 2 or 3 times, and those who are not on all lists might miss
something when 1 person did not continue to cc to the other list !!

Then the moderator has to step in and ask everyone not to cc and stay on
topic !

I'm sure everyone on this list has had that experience before ???

I think this is one that never gets solved.

My opinion is that I rather get it all, and just delete what I don't want.
Yeah, it takes time and bandwidth, but at least I know I will get EVERYTHING
I want, and NOTHING I dodn't want, because I AM IN CHARGE ;-)

Either way, keep up the good work people; you are helping so many with your
free time !


Cheers!
Mark Harrop

mharrop@iprimus.com.au

    `\|||/
      (@@)
ooO_(_)_Ooo___________________________
_____|_____|_____|_____|_____|_____|_____|

Epping, Melbourne, Victoria, AUSTRALIA.
----- Original Message -----
From: "William Knop" <w_knop@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 26, 2001 1:55 PM
Subject: LKML signal to noise ratio-- improvement


| Hello All,
| I have recently been reading new and archived posts regarding the wish for
a
| more organized development system for the kernel. Some people want
| centralized version control and bug tracking, some want sophisticated
tools
| to accomplish something close to what we already have, some just don't
feel
| like investing the effort to devise a better system, and some insist the
way
| things are done are the best way to do them.
|
| I happen to know there is a better way of doing things, because a major
| complaint is the 'signal to noise ratio'. The proverb, "One man's trash is
| another man's treasure" is a great way to think about the problem.
|
| For instance, some people like discussing major reworks of the kernel,
where
| the change is not necessary. Hackers like to screw around in this area,
and
| most of the time developers and maintainers do not. In fact, developers
and
| maintainers rather appreciate bug and patch submissions, but do not
| appreciate updating their kill lists.
|
| I believe Alan Cox put it well when he said, "Did you have to change the
| subject line. It makes it harder to kill file when people keep doing
that,"
| regarding the /proc reworking. Correct me if I am wrong, but he probably
| does not want to hear the rework/overhaul discussions.
|
| Since this is a mailing list, I don't believe the correct solution is to
let
| search tools evolve our problems away. If you read from an archive, that
| would be acceptable, but if you subscribe it is not.
|
| So, where am I going with this? Well, the solution is that lkml be split
| into sublists, namely linux-kernel-bug, linux-kernel-patch,
| linux-kernel-help, and linux-kernel-discussion (or perhaps -misc or
| -general, although -discussion seems to encourage posting more, which IMHO
| is a good thing). I like to think of it as a "non-invasive" solution. One
| could have a symbolic "linux-kernel" which subscribes to all the lists so
| the current lkml list of subscribers could be preserved.
|
| Discussion related to bugs and patches would spawn from the posts of bugs
| and patches in their respective lists, and misc ones would start and be
| contained in the general -discussion list.
|
| A bonus is the honey pot technique used to discover network viruses could
be
| used to kill spam from lkml. Presumably the advertisers would post to more
| than one of the l-k lists, so if a post goes to more than one list within
a
| minute of eachother, delete them both. The list could generate and store
| (for a minute) a checksum and maybe length for each message to compare to
| new messages incoming on the other lists. So the message would be delayed
a
| minute before being sent, but less spam. Of course this requires extra
| development/programming of the mailing system, so I consider it
low-priority
| compared to simply separating the list. It could be that vger already does
| this, using the other lists; I don't know.
|
| -Will
|
| PS I am not subscribed anymore, so if you could CC responses to me, I'd
| appreciate it.
|
| _________________________________________________________________
| Send and receive Hotmail on your mobile device: http://mobile.msn.com
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/


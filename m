Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBMSIF>; Tue, 13 Feb 2001 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRBMSHz>; Tue, 13 Feb 2001 13:07:55 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:38411 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129185AbRBMSHw>; Tue, 13 Feb 2001 13:07:52 -0500
Date: Tue, 13 Feb 2001 13:08:13 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Timur Tabi <ttabi@interactivesi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [LK] Re: lkml subject line
In-Reply-To: <1tjGM.A.tdG.0uWi6@dinero.interactivesi.com>
Message-ID: <Pine.LNX.4.33.0102131247130.16755-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Timur Tabi wrote:

>> Which is retarded.  The subject line is for the subject.  Other
>> headers exist for letting one know where they came from.
>
>There's only one problem with this.  It assumes that for every
>mailing list you are on, you will have a folder into which all
>such email is placed.

No it does not.  You are free to filter your mail however you
wish.  I put all the "caudium" lists into one folder for example.
These lists unfortunately put the stupid [caudium-blah] in the
subject, but I now can filter it out. If I want to look at just a
specific list, I can use PINE's search feature.

>I subscribe to about 35 mailing lists, many of which have low
>traffic.

I subscribe to 90+ lists, many of which are low traffic.

>I don't want to create a separate folder for each list.

Nor do I.

>Because most of these mailing lists are on Yahoo Groups, I get
>a nice prefix to each subject line that tells me the mailing
>list.

If that is important to you, and is the default for the list,
cool.


>In can then filter all of these messages into one folder. So
>instead of having to scan 20 folders, I only need to scan one.

You can do the same wether or not the subject contains the list
name.  It is very simple.


>The point I'm trying to make is that there are perfectly valid
>reasons to include some text on the subject line to indicate
>the mailing list.

I have yet to hear a single good reason.  Any reasons I've heard
any time in the last 7 years, have NOT been good reasons because
the reasons given always have another way of doing the EXACT same
thing, only without abusing the subject header.
Give me a good reason, and I'll give you an alternate way of
achieving the same thing - without messing up the subject.

>People who feel this way may be in the majority, but then
>again, people who use Linux are also in the majority.  Does
>that make them wrong or "retarded"?  No.

Read what I said again.  I never said anyone was retarded at all.
I said specifically:  "Which is retarded" refering to the process
of a list putting the name on the subject header.

What I am trying to say is that there are better ways of doing
the exact same things, without abusing the DEFINITIONS of a given
header.  To illustrate further, consider instead of using the
subject header if mailing lists put the list name in the DATE
header.

Date: [linux-kernel] Jan 12, 2000 ....

Pretty dumb eh?  And annoying.  And, you cant read the date in
index mode because all you see is:

    419 [linux-k Timur Tabi          (3,617) Re: [LK] Re: lkml subject line

Can't see the date because the dumb list puts the listname in the
date field!

No different for subject.  Here is an example:

  N  69 Jan 29 David Hedbor        (3,446) [caudium-commits] CVS: caudium/server


So when I look at the index, to scan which messages might be
interesting, by looking at the subject - which has the purpose of
summarizing the content/context of the message, I see 60%
bullshit, and 14 characters of subject.  In order to get any
useful meaning I must read every message just to see a useful
part of the subject.  Either that or use a 160 column video mode
instead of 80.  Why?  Because someone sets a list to put the damn
list name in the subject, because some user can't learn how to
use an email filter properly.

What is right:

1) not putting the thing in the subject from the list side
2) If an end user wants it in the subject, they can set up a mail
filter to PUT it in the subject.

:0 fwh
* ^Sender:.*owner-linux-kernel
| sed -e 's/^Subject: /Subject: [lkml]/'
:0 A:
lkml

The above filter should add [lkml] to your subject line.  So why
try to force it on everyone?

If the above procmail filter doesn't work (untested) let me know
and I will MAKE it work.  Windows users - tough luck - procmail
is open source - hire someone to port it...


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------



Windows 95(n) - 32-bit extensions and graphical shell for a 16-bit patch
to an 8-bit operating system originally coded for a 4-bit microprocessor,
written by a 2-bit company that can't stand 1 bit of competition. 


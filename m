Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137163AbREKQKC>; Fri, 11 May 2001 12:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137164AbREKQJ4>; Fri, 11 May 2001 12:09:56 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:31501 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S137163AbREKQIn>; Fri, 11 May 2001 12:08:43 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Hacksaw <hacksaw@hacksaw.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A49.00589003.00@smtpnotes.altec.com>
Date: Fri, 11 May 2001 11:07:45 -0500
Subject: Re: Not a typewriter
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2001 at 06:20:34 PM Hacksaw <hacksaw@hacksaw.org> wrote:

>Heaven help us when tradition is more important than clarity.
>

If clarity is the most important consideration, then other things should be
changed as well.  For instance, the command we use to search for text strings in
files should be called "textsearch."  That's a lot more clear than "grep."

>Typewriter has always been wrong. I'd agree that "Not a teletypewriter" would
>suffice.
>

But the original message said "typewriter."  (The "wrongness" is part of its
charm.)  If the wording is going to be changed, then it's better to abandon the
tradition altogether and use one of the more descriptive and "correct" messages
you and others have proposed.

>On the other hand "Inappropriate ioctl for device" is also not very clear.
>
>I'd like to see "Not a serial or character device" or "Not a serial device" if
>that's more appropriate. Something like that...

My point is that someone who sees the "typewriter" message and doesn't
understand it will have to dig a bit to find out what it means.  Finding it
almost certainly will involve uncovering some of the history and folklore of
Unix.  In the "Intro to Unix" classes I've taught over the years, I've always
made a point of explaining the background of things like this -- such as the
relation of grep to the g/re/p expression of ed, ex and vi; where biff got its
name; what the letters stand for in awk; why creat doesn't end in an "e;" and so
forth.  I tell the class that Unix has quirky, eccentric, whimsical elements
because many of the things in it were written by quirky, eccentric, or whimsical
people.  The comment at the bottom of some versions of the tunefs man page (such
as the HP-UX version) is an example I like to use:  "You can tune a file system,
but you can't tune a fish."  I tell them they'll understand the Unix way of
thinking faster if they approach it with an inquisitive, playful spirit rather
than as a stuffy business system.  It's supposed to be correct; it's supposed to
be efficient; but it's also supposed to be fun, and sometimes the fun is worth
sacrificing a little of the other qualities in trivial areas.

I guess what I'm trying to say is that "Life With Unix" should be required
reading for anyone who goes near a Unix (or Linux) system.

Wayne



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293252AbSCJVOQ>; Sun, 10 Mar 2002 16:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293244AbSCJVOG>; Sun, 10 Mar 2002 16:14:06 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:25102 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S293243AbSCJVN6>; Sun, 10 Mar 2002 16:13:58 -0500
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Sun, 10 Mar 2002 22:16:03 +0100
Organization: Cistron
Message-ID: <a6giak$c7o$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207132558.D27932@work.bitmover.com> <3C8B1B25.7000208@namesys.com> <200203101941.g2AJfSD19756@lmail.actcom.co.il> <3C8BBFCF.5010504@namesys.com>
X-Trace: ncc1701.cistron.net 1015794837 12536 213.46.44.164 (10 Mar 2002 21:13:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hans Reiser" <reiser@namesys.com> wrote in message
news:cistron.3C8BBFCF.5010504@namesys.com...
> Itai Nahshon wrote:
>
> >On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> >
> >>I think that if version control becomes as simple as turning on a plugin
> >>for a directory or file, and then adding a little to the end of a
> >>filename to see and list the old versions, Mom can use it.
> >>
> >
> >IIRC that was a feature in systems from DEC even before
> >VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
> >of file.txt.
> >
>
> Was it easy?  Did people like it?  Any lessons/successes?
>
> Hans
>

It was fabulous at that time. The first time you create a file, it gets ";1"
appended to it's filename. When you edit it, it gets saved under the same name,
this time appended by ";2". Edit it again... whell, you get the picture.
Cleaning up was as simple as "$ PURGE /KEEP=3" to keep the last three versions.

For these days with sometimes hundreds of files, it might become confusing when
'ls' shows all versions of all files, but back then it worked well.

Rob






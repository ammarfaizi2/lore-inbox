Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTFJSBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTFJSBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:01:11 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:65006 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263777AbTFJSBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:01:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Timothy Miller <miller@techsource.com>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Coding standards. (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Date: Tue, 10 Jun 2003 13:14:16 -0500
X-Mailer: KMail [version 1.2]
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com> <3EE4D80A.2050402@techsource.com>
In-Reply-To: <3EE4D80A.2050402@techsource.com>
MIME-Version: 1.0
Message-Id: <03061013141600.06462@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 13:55, Timothy Miller wrote:
> Davide Libenzi wrote:
>
> > There's no such a thing as "horrible coding style", since coding style is
> > strictly personal. Whoever try to convince you that one style is better
> > than another one is simply plain wrong. Every reason they will give you
> > to justify one style can be wiped with other opposite reasons. The only
> > horrible coding style is to not respect coding standards when you work
> > inside a project. This is a form of respect for other people working
> > inside the project itself, give the project code a more professional look
> > and lower the fatigue of reading the project code. Jumping from 24
> > different coding styles does not usually help this. I do not believe
> > professional developers can be scared by a coding style, if this is the
> > coding style adopted by the project where they have to work in.
>
> Oh, yes, there is most certainly "horrible coding style".  When I was in
> college, I met one CS student after another who really just did not
> belong in CS, and you should have seen the code they wrote.
>
> Imagine a 200 line program which is ALL inside of main().  There is no
> indenting.  Lines of code are broken in random places.  Blank lines are
> inserted randomly.  The variable names chosen are a, b, c, d, e, etc.
> It's impossible to tell which '{' is associated with which '}'.
>
> It's been a while.  I can't remember all of the violations of reason and
> sanity I saw.  I pity the grad students who were faced with grading
> these monstrosities.

ummm been there... Actually, after the first 20 it got easy... If I couldn't
read it, it got an "F" (whether it worked or not).

If it could be read with difficulty (and worked) it got a D
If it could be read and worked it got a C
If it could be read and was clear (and worked) it got a B
If it was short, clear, and worked it got an A

And I have met some of the idiots (including Piled higher and Deeper ones) 
that couldn't program their way through a "hello there" program.

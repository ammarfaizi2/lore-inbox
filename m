Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTJGS43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTJGS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:56:29 -0400
Received: from [209.195.52.120] ([209.195.52.120]:36797 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262583AbTJGS41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:56:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       Krishna Akella <akellak@onid.orst.edu>, Paul Jakma <paul@clubi.ie>,
       kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
Date: Tue, 7 Oct 2003 11:52:04 -0700 (PDT)
Subject: Re: Can't X be elemenated?
In-Reply-To: <20031007121825.GA323@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0310071148300.19220@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell>
 <Pine.LNX.4.58.0309301316510.12484@dlang.diginsite.com>
 <20031007040449.GM205@openzaurus.ucw.cz> <3F82780C.8080408@pixelized.ch>
 <20031007121825.GA323@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Pavel Machek wrote:

>
> Hi!
>
> > >>different toolkits exist becouse people are solving different problems.
> > >>which set of people do you propose telling that their desires don't
> > >>matter?
> > >
> > >
> > >Well, qt and gtk solve pretty much same problem,
> > >their existence seems like historical accident to me.
> >
> > Hmm. World (also in linux kernel) is not so efficient!
> > There are more tools for same task/problem. Maybe in the long run only one
> > tools per problem will survive, but the diversity is good, also at cost of
> > the duplicate work.
>
> It is not where you have competing interfaces.
>
> > Do you want only one distribution for user, one for small companies, one
> > for schools,...? Do you want only one web server implementation? Only one
> > filesystem per task (only one journaling FS)?
> > Are they all "historical accident"?
>
> Well, I'm pretty glad there's only one glibc, and only one http
> protocol, and only one X protocol. And it would be way better if there
> was just one toolkit commonly used on Linux.

true, there is only one glibc, but there is not just one c library (uclib,
etc) and while there is only one http protocol there is not just a single
webserver api (netscape, IIS, apache 1.3, apache 2.0 all have different
api's)

there do need to be common points, in the case of GUI's on *nix X is the
common point, the toolkits used to write programs don't need to all have
the exact same api.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

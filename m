Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSLVSsi>; Sun, 22 Dec 2002 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSLVSsi>; Sun, 22 Dec 2002 13:48:38 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:63918 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265139AbSLVSsh>; Sun, 22 Dec 2002 13:48:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 22 Dec 2002 10:53:09 -0800
Message-Id: <200212221853.KAA12889@adam.yggdrasil.com>
To: dave@codemonkey.org.uk, hannal@us.ibm.com
Subject: Re: Dedicated kernel bug database
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-12-20, Dave Jones wrote:
>On Thu, Dec 19, 2002 at 06:01:34PM -0800, Hanna Linder wrote:
>
> > > Anything in "OPEN" state isn't really assigned to anyone yet.
> > > (the state would really better be named "NEW", but it's not). 
> > > People should move it to "ASSIGNED" if they're working on it.
> >      So the process is to query for all open bugs (but not 
> > assigned) then email each person to let them know you are 
> > working on it?
>
>Why generate noise ?
>
>Query bugs.
>Find something interesting.
>Fix it.
>THEN email person (or better yet, add to bugzilla entry).
>
>Flooding the database with "I'm working on this" reports
>buys absolutely nothing.

	"I'm working on this" messages (in my experience in lkml at
least) help people avoid duplication of effort, and perhaps sometimes
help multiple people who want to work on the same bug find each other.

	I think the "noise" would mostly be a user interface issue.
Imagine, for example, if the "I'm working on this" messages were
consolidated into a single link that said something like "4 people are
working on this bug", which you could click on for the details.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTKNDCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 22:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTKNDCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 22:02:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:16000 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264503AbTKNDC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 22:02:29 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 13 Nov 2003 19:01:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031113172015.GA23754@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0311131854540.2095-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Larry McVoy wrote:

> On Thu, Nov 13, 2003 at 09:14:27AM -0800, Davide Libenzi wrote:
> > On Thu, 13 Nov 2003, Larry McVoy wrote:
> > 
> > > I suppose it sounds like we don't want to give out more free engineering
> > > but let's put things into perspective.  The CVS server has about 6 users.
> > > It's cost us a pile of money to build and support that technology.
> > > For 6 users.  On the other hand, there are thousands if not tens of
> > 
> > Larry, if there are really six users (i'm one of them, rsync) among 
> > pserver and rsync access, I am the first to tell you shut it down. It is 
> > not worth. On the other hand IIRC it was you that, when Pavel showed up 
> > with the bitbucket hack to extract metadata from BK, volunteered to do it 
> > internally inside BM. Do I remember correctly?
> 
> Not really, the revision history of the CVS gateway predates Pavel's so-called
> hacks.

Looking here:

http://lkml.org/lkml/2003/2/15/96

it didn't seem so, but it's not that makes a huge difference.



> I don't mind us supporting this gateway for the small number of users, if it 
> makes them happy, that's fine.  What I mind is people coming back and asking
> for more stuff for a tiny number of people.  That doesn't make sense.  We 
> should put our efforts into helping the people using BK, not the people using
> CVS.  If you want to help yourselves, that's a fine idea, go for it.

I really would like to know from Peter/DaveM how many hits the rsync of 
the CVS repo at kernel.org has. If really a few cats are looking at it and 
if for BM is an hassle to support it, we have to ask ourselves if it is 
worth. Both for kernel.org maintainers and for BM.
(rsync on CVS repo on kernel.org does not give me any new data by days)



- Davide


